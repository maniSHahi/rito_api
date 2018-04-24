Dir[File.dirname(__FILE__) + '/requests/*.rb'].each {|file| require file } # Subclass.rb
require 'moneta'
require 'redis'
module RitoApi 

    class Client # Setting up a client to make request to league of legends api.
        attr_accessor :region

        def initialize(api_key, region, cache = false, ttl = 1) # Initializes the client.
            @api_key = api_key
            @region = region
            @ttl = ttl 
            unless cache
                @cache_store = nil
            else
                @cache_store = Moneta.new(:Redis, expires: @ttl)  # ttl = time till the cache expires [Defaults to 1 as 0 means never expire.]
                # @cache_store.clear
            end
        end

        def close # Closes the client.
            unless @cache_store.nil?
                @cache_store.clear
            end
        end

        def change_region(region) # Changes region after the client is already initialized.
            @region = region
        end

        def summoner # Creates a new instance of summoner class. Used to make request relating to summoner. Check requests/summoner.rb for methods.
            RitoApi::Requests::Summoner.new(@api_key, @region, @cache_store)
        end

        def challenger # Creates a new instance of challenger class. Used to make request relating to summoner. Check requests/challenger.rb for methods.
            RitoApi::Requests::Challenger.new(@api_key, @region, @cache_store)
        end
        
        def champion # Creates a new instance of champion class. Used to make request relating to champion. Check requests/champion.rb for methods.
            RitoApi::Requests::Champion.new(@api_key, @region, @cache_store)
        end
        
        def matches
            RitoApi::Requests::Match.new(@api_key, @region, @cache_store)
        end
        
        def item
            RitoApi::Requests::Item.new(@api_key, @region, @cache_store)
        end
        
    end
end


# client = RitoApi::Client.new('RGAPI-89538f52-2141-443c-aaaa-9cb0d44ea380', 'na', true, 5)
# summoner = client.summoner
# puts summoner.find('rockerturner')
# puts summoner.find('catdg')
# puts summoner.find('r0ckerm4n', 300)
# puts client.find('rockerturner')
# puts client.find(ign)
# client.close
# puts client.request_url("lol/summoner/v3/summoners/by-name/rockerturner")
# puts client.summoner.cache_store.nil?

# puts client.summoner.find('rockerturner')
# if client.cache?
#     puts 'yes'
# else
#     puts 'no'
# end
# client.cache_store
# puts client.summoner.cached?('rockerturner')

