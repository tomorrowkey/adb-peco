class Adb::Peco::Command
  attr_reader :argv

  def initialize(argv)
    @argv = argv
  end

  def serial_option
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

  def adb_action
    argv.reject{|a| a[0] == '-'}.first
  end

  def need_serial_option?
    !['help',
      'devices',
      'version',
      'start-server',
      'stop-server',
    ].include?(adb_action)
  end

  def quote(args)
    args.map{|a| a.include?(' ') ? %Q{"#{a}"} : a }
  end

  def build
    [ 'adb',
      serial_option,
      quote(argv),
    ].flatten.join(' ')
  end
end
