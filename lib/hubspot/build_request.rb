require 'httparty'
require 'json'
require_relative 'urls'
module Hubspot
  class BuildRequest < Client
    include HTTParty
    
    def self.search_contact(params={})
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+search_contact_url
      post(url, params)
    end



    def self.create_user(params={})
      raise "params cant be empty or nil" if params.empty? || params.nil?
      raise "need params properties" unless params.keys.include?(:properties)
      url = base_v3_url+contact_url
      post(url, params)
    end

    def self.create_deal(params={})
      raise "params cant be empty or nil" if params.empty? || params.nil?
      raise "need params properties" unless params.keys.include?(:properties)
      url = base_v3_url+deals_url
      post(url, params)
    end

    def self.update_deal(params={}, id)
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+deals_url+"/#{id}"
      patch(url, params)
    end

    def self.create_association(params={})
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+association_url(params)
      update(url)
    end
    
    private

      def self.patch(url, params)
        HTTParty.patch(url, body: params.to_json, headers: set_header)
      end

      def self.update(url)
        HTTParty.put(url, headers: set_header)
      end
      
      def self.post(url, params)
        HTTParty.post(url, body: params.to_json, headers: set_header)
      end

      def self.base_v3_url
        Hubspot::URLS[:base_v3]
      end

      def self.base_v4_url
        Hubspot::URLS[:base_v4]
      end

      def self.search_contact_url
        Hubspot::URLS[:search_contact]
      end
      def self.contact_url
        Hubspot::URLS[:contact]
      end
      def self.deals_url
        Hubspot::URLS[:deals]
      end
      def self.association_url(params)
        arr_url = Hubspot::URLS[:association_contact_deal].split("/")

        new_url = arr_url.map do |word|
          params[word.to_sym].nil? ? word : params[word.to_sym]
        end
        new_url.join("/")
      end
      
      def self.set_header
        {
          "Authorization" => "Bearer #{private_key}",
          'Content-Type' => 'application/json'
        }
      end

      def self.private_key
        Hubspot::Settings.config[:private_key]
      end
  
  end
end