libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'owd/base'

module OWD
  class Configuration
    attr_accessor :client_id, :client_authorization, :testing, :environment

    def initialize
      @client_id = @client_authorization = 'xxx'
      @environment = 'staging'
      @testing = false
    end
  end

  class << self
    @@configuration ||= Configuration.new

    def configuration
      @@configuration
    end

    def configure
      yield(configuration)
    end
  end
end
