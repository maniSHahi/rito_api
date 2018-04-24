require 'uri'
require 'httparty'
module RitoApi
    # Request Module that handles every requests.
    module Requests 
        attr_accessor :region
        class Basic # Every other request class inherits from this class.
            
            def initialize(api_key, region, cache_store) # Initializing
                @api_key = api_key
                @region = region
                @cache_store = cache_store
                
            end

            
            def cached?(key)
                unless @cache_store.nil?
                    @cache_store.key?(key)
                end
            end

            def region_tag
                region_tag = { :na => 'na1', 
                    :eune => 'eun1', 
                    :euw => 'euw1',
                    :jp => 'jp1',
                    :kr => 'kr',
                    :lan => 'la1',
                    :las => 'la2',
                    :br => 'br1',
                    :oce => 'oc1',
                    :tr => 'tr1',
                    :ru => 'ru',
                    :pbe => 'pbe1' }
                return region_tag[@region.downcase.to_sym]
            end

            def base_url
                return "https://#{region_tag}.api.riotgames.com/"
            end

            def request_url(pUrl)
                return URI.encode("#{base_url}#{pUrl}?api_key=#{@api_key}")
            end

            def clean_url(url)
                return url.split('?')[0]
            end

            def make_request(url, ttl)
                unless @cache_store.nil?
                    return @cache_store.fetch(clean_url(url)){@cache_store.store(clean_url(url), symbolize(HTTParty.get(url).parsed_response), expires: ttl)}
                else
                    return symbolize(HTTParty.get(url).parsed_response)
                end
            end
            
            def symbolize(object)
                if object.is_a?Hash
                    symbolized = Hash[object.map { |k, v| [k.to_sym, symbolize(v)] }]
                    return symbolized
                elsif object.is_a?Array
                    symbolized = []
                    object.each {|x| symbolized.push(Hash[x.map { |k, v| [k.to_sym, symbolize(v)] }])}
                    return symbolized
                end
                return object
            end
            
            def leagueVer
                HTTParty.get('https://ddragon.leagueoflegends.com/api/versions.json').parsed_response[0]
            end

        end

    end
    
end