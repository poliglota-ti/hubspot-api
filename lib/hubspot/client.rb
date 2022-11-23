require_relative 'settings'
module Hubspot
  class Client
    
    def initialize
      raise 'Please, pass key of hubspot private app' if get_config.nil? || get_config.empty?
      super
    end

    private
      def get_config
        Settings.config[:private_key]
      end
  end
end