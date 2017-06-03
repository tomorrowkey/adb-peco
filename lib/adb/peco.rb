require 'adb/peco/version'
require 'device_api/android'
require 'peco_selector'

module Adb
  module Peco
    AdbUnavailableError = Class.new(StandardError)

    def self.serial_option
      return nil unless adb_action
      return nil unless need_serial_option?

      devices = DeviceAPI::Android.devices
      return nil if devices.size <= 1 || devices.size == 0

      device = PecoSelector.select_from(devices.map{|device|
        ["#{device.model} (#{device.qualifier})", device]
      }).first
      "-s #{device.qualifier}"

    rescue PecoSelector::PecoUnavailableError => e
      puts e.message
      exit 1
    end

    def self.adb_available?
      system('which', 'adb', out: File::NULL)
    end

    def self.ensure_adb_available
      unless adb_available?
        raise AdbUnavailableError, 'adb command is not available.'
      end
    end

    def self.adb_action
      ARGV.reject{|a| a[0] == '-'}.first
    end

    def self.need_serial_option?
      !['help',
        'devices',
        'version',
        'start-server',
        'stop-server',
      ].include?(adb_action)
    end

    def self.quote(args)
      args.map{|a| a.include?(' ') ? %Q{"#{a}"} : a }
    end

    begin
      ensure_adb_available
    rescue AdbUnavailableError => e
      puts e.message
      exit 1
    end

    command = ['adb', serial_option, quote(ARGV)].flatten.join(' ')
    begin
      puts "+ #{command}"
      system(command)
    rescue Interrupt
      # Ignore
    end
  end
end
