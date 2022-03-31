require 'adb/peco/command'

class Adb::Peco::Executor
  AdbUnavailableError = Class.new(StandardError)

  def adb_available?
    system('which', 'adb', out: File::NULL)
  end

  def ensure_adb_available
    unless adb_available?
      raise AdbUnavailableError, 'adb command is not available.'
    end
  end

  def execute
    begin
      ensure_adb_available
    rescue AdbUnavailableError => e
      puts e.message
      exit 1
    end

    command = Adb::Peco::Command.new(ARGV).build

    begin
      puts "+ #{command}"
      system(command)
    rescue Interrupt
      # Ignore
    end
  end
end
