require_relative('basic')
module RitoApi

    module Requests
        
        class Item < Basic
            
            def get_icon(id)
                
                return "https://ddragon.leagueoflegends.com/cdn/#{leagueVer}/img/item/#{id}.png"

            end
            
            def spells_icon(id)
                
                spells = {
                            34 =>'SummonerSiegeChampSelect2',
                            12 =>'SummonerTeleport',
                            33 =>'SummonerSiegeChampSelect1',
                            3 =>'SummonerExhaust',
                            21 =>'SummonerBarrier',
                            13 =>'SummonerMana',
                            39 =>'SummonerSnowURFSnowball_Mark',
                            4 =>'SummonerFlash',
                            32 =>'SummonerSnowball',
                            14 =>'SummonerDot',
                            36 =>'SummonerDarkStarChampSelect2',
                            35 =>'SummonerDarkStarChampSelect1',
                            30 =>'SummonerPoroRecall',
                            6 =>'SummonerHaste',
                            7 =>'SummonerHeal',
                            31 =>'SummonerPoroThrow',
                            1 =>'SummonerBoost',
                            11 =>'SummonerSmite',
                        }
                        
                return "https://ddragon.leagueoflegends.com/cdn/#{leagueVer}/img/spell/#{spells[id]}.png"
                
            end
            
        end
        
    end

end