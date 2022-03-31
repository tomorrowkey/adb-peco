require 'adb/peco/version'
require 'device_api/android'
require 'peco_selector'
require 'adb/peco/executor'

module Adb
  module Peco
    Executor.new.execute
  end
end
