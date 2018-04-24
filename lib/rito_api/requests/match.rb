module RitoApi
    
    module Requests
        
        class Match < Base
            
            def get(matchId, ttl = @ttl)
                
                return make_request(request_url("lol/match/v3/matches/#{matchId}"), ttl)
                
            end
            
            def get_bans(matchId, ttl = @ttl)
                payCheck = get(matchId, ttl)[:teams]
                bans = []
                payCheck.each {|x| bans.push(x[:bans])}
                return bans
            end
            
            def get_players(matchId, ttl = @ttl)
                get(matchId, ttl)[:participantIdentities]
            end
            
            def stats(matchId, ttl = @ttl)
                get(matchId, ttl)[:participants]
            end
            
            def player_stats(matchId, championId, ttl = @ttl)
                playerStats = {}
                stats(matchId, ttl).each do |pStats|
                    if pStats[:championId] == championId
                        playerStats = pStats
                    end
                end
                return playerStats
            end
            
            def player_identities(matchId, participantId, ttl = @ttl)
                playerIdentity={}
                get_players(matchId, ttl).each do |player| 
                    if player[:participantId] == participantId
                        playerIdentity = player
                    end
                end
                return playerIdentity
            end
        end
        
    end
    
end