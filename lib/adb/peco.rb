require 'adb/peco/version'
require 'device_api/android'
require 'peco_selector'

module Adb
  module Peco
    def self.serial_option
      return nil unless adb_action
      return nil unless need_serial_option?

      devices = DeviceAPI::Android.devices
      return nil if devices.size <= 1 || devices.size == 0

      device = PecoSelector.select_from(devices.map{|device|
        ["#{device.model} (#{device.serial})", device]
      }).first
      "-s #{device.serial}"

    rescue PecoSelector::PecoUnavailableError => e
      puts e.message
      exit 1
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

    command = ['adb', serial_option, ARGV].flatten.join(' ')
    begin
      system(command)
    rescue Interrupt
      # Ignore
    end
  end
end
