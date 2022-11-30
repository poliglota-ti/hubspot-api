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

    def self.get_deal_by_id(id)
      raise "id cant be empty or nil" if id.nil?
      url = base_v3_url+deals_url+"/#{id}"
      get(url)
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
      url = base_v3_url+set_url(params, "association_contact_deal")
      update(url)
    end

    def self.search_property_by_name(params)
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+set_url(params, "properties")
      get(url)
    end

    def self.create_property(params)
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+property_url
      post(url, params)
    end

    def self.update_contact(params, id)
      raise "params cant be empty or nil" if params.empty? || params.nil?
      url = base_v3_url+contact_url+"/#{id}"
      patch(url, params)
    end
      
    private

      def self.get(url)
        HTTParty.get(url, headers: set_header)
      end

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
      def self.property_url
        Hubspot::URLS[:property]
      end

      def self.set_url(params, set_url)
        arr_url = Hubspot::URLS[set_url.to_sym].split("/")

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