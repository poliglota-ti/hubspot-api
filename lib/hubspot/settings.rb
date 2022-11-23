module Hubspot
  class Settings
    Property = Struct.new :private_key

    def self.configure
      return "No block given" unless block_given?
      yield config
    end

    def self.config
      @config ||= Property.new
    end 
  end
end