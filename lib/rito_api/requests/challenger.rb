module RitoApi
   
    module Requests
       
        class Challenger < Base
            
            def solo_queue(count = 0, ttl = @ttl) # Not passing an argument / passing string (unless string is number)/ 0 => returns all 200 results.
                payCheck = make_request(request_url("/lol/league/v3/challengerleagues/by-queue/RANKED_SOLO_5x5"), ttl)[:entries]
                payLoad= []
                if count.to_i <= 0 || count.to_i >200
                    return payCheck
                else
                    payCheck.sort!{|x, y| y[:leaguePoints] <=> x[:leaguePoints]}
                    (0...count).each{|x| payLoad.push(payCheck[x])}
                    return payLoad
                end

            end
        
        end
       
    end
    
end