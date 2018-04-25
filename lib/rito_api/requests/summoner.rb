require_relative('basic')
module RitoApi

    module Requests

        class Summoner < Basic

            def find(ign, ttl = @ttl) # Finds summoner using the summonerName.
                return make_request(request_url("lol/summoner/v3/summoners/by-name/#{ign}"), ttl)
            end

            def find_by_summonerID(id, ttl = @ttl) # Finds summoner using summonerID. [Not encouraged method to be used, unless under the hood.]
                return make_request(request_url("lol/summoner/v3/summoners/#{id}"), ttl)
            end

            def find_by_accountID(id, ttl = @ttl) # Finds summoner using accountID. [Don't use unless absolutely necessary]
                return make_request(request_url("lol/summoner/v3/summoners/by-account/#{id}"), ttl)
            end
            
            def rank_info(ign, ttl = @ttl)
                unless ign.is_a?Numeric
                    return make_request(request_url("lol/league/v3/positions/by-summoner/#{find(ign)[:id]}"), ttl)
                else
                    return make_request(request_url("lol/league/v3/positions/by-summoner/#{ign}"), ttl)
                end
            end
            
            def solo(ign, ttl = @ttl)
                rank = {}
                rank_info(ign,ttl).each do |r|
                    if r[:queueType] == 'RANKED_SOLO_5x5'
                        rank = r
                    end
                end
                return rank
            end
            
            def flex(ign, ttl = @ttl)
                rank = {}
                rank_info(ign,ttl).each do |r|
                    if r[:queueType] == 'RANKED_FLEX_SR'
                        rank = r
                    end
                end
                return rank
            end
            
            def tt(ign, ttl = @ttl)
                rank = {}
                rank_info(ign,ttl).each do |r|
                    if r[:queueType] == 'RANKED_FLEX_TT'
                        rank = r
                    end
                end
                return rank
            end
            
            def recent_matches(ign, ttl = @ttl)
                return make_request(request_url("lol/match/v3/matchlists/by-account/#{find(ign)[:accountId]}/recent"), ttl)
            end
            
            def top_positions(ign, ttl = @ttl)
                positions=[]
                recent_matches(ign, ttl)[:matches].each do |x|
                    
                    if x[:lane] == 'BOTTOM'
                        positions.push(x[:role])
                    else
                        positions.push(x[:lane])
                    end
                end
                positions = Hash[positions.group_by(&:itself).map {|k,v| [k, v.size] }]
                return (positions.sort_by{|k,v|v}.reverse.map{|k,v| k}).values_at(0,1)
            end
            
            def icon(iconId)
                icon = "https://ddragon.leagueoflegends.com/cdn/#{leagueVer}/img/profileicon/#{iconId.to_i}.png"
                return icon
            end
        
            def champion_mastery(ign, count = 0, ttl= @ttl)
                unless ign.is_a?Numeric
                    mastery = make_request(request_url("lol/champion-mastery/v3/champion-masteries/by-summoner/#{find(ign)[:id]}"), ttl)
                else
                    mastery = make_request(request_url("lol/champion-mastery/v3/champion-masteries/by-summoner/#{ign}"), ttl)
                end
                topChamps=[]
                
                if count.to_i <= 0 or count.to_i >= mastery.size
                    return mastery
                else
                    (0...count.to_i).each{|x| topChamps.push(mastery[x])}
                    return topChamps
                end
            end
             
        end

    end
    
end