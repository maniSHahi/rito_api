module RitoApi
    
    module Requests
        
        class Match < Basic
            
            def get_match(matchId, ttl = @ttl)
                
                return make_request(request_url("lol/match/v3/matches/#{matchId}"), ttl)
                
            end
            
            def get_bans(matchId, ttl = @ttl)
                payCheck = get_match(matchId, ttl)[:teams]
                bans = []
                payCheck.each {|x| bans.push(x[:bans])}
                return bans
            end
            
            def get_players(matchId, ttl = @ttl)
                get_match(matchId, ttl)[:participantIdentities]
            end
            
            def stats(matchId, ttl = @ttl)
                get_match(matchId, ttl)[:participants]
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
            
            def get_runes(matchId, championId, ttl = @ttl)
                slots = {
                        8200 => {
                                :key => "Sorcery", 
                                :icon => "perk-images/Styles/7202_Sorcery.png", 
                                :runes => {
                                            8210=>{:key=>"Transcendence", :icon=>"perk-images/Styles/Sorcery/Transcendence/Transcendence.png"}, 
                                            8214=>{:key=>"SummonAery", :icon=>"perk-images/Styles/Sorcery/SummonAery/SummonAery.png"}, 
                                            8224=>{:key=>"NullifyingOrb", :icon=>"perk-images/Styles/Sorcery/NullifyingOrb/Pokeshield.png"}, 
                                            8226=>{:key=>"ManaflowBand", :icon=>"perk-images/Styles/Sorcery/ManaflowBand/ManaflowBand.png"}, 
                                            8229=>{:key=>"ArcaneComet", :icon=>"perk-images/Styles/Sorcery/ArcaneComet/ArcaneComet.png"}, 
                                            8230=>{:key=>"PhaseRush", :icon=>"perk-images/Styles/Sorcery/PhaseRush/PhaseRush.png"}, 
                                            8232=>{:key=>"Waterwalking", :icon=>"perk-images/Styles/Sorcery/Waterwalking/Waterwalking.png"}, 
                                            8233=>{:key=>"AbsoluteFocus", :icon=>"perk-images/Styles/Sorcery/AbsoluteFocus/AbsoluteFocus.png"}, 
                                            8234=>{:key=>"Celerity", :icon=>"perk-images/Styles/Sorcery/Celerity/CelerityTemp.png"}, 
                                            8236=>{:key=>"GatheringStorm", :icon=>"perk-images/Styles/Sorcery/GatheringStorm/GatheringStorm.png"}, 
                                            8237=>{:key=>"Scorch", :icon=>"perk-images/Styles/Sorcery/Scorch/Scorch.png"}, 
                                            8243=>{:key=>"TheUltimateHat", :icon=>"perk-images/Styles/Sorcery/TheUltimateHat/TheUltimateHat.png"},
                                          }
                                           
                                },
                                
                        8300 => {
                                :key => "Inspiration",
                                :icon => "perk-images/Styles/7203_Whimsy.png",
                                :runes => {
                                            8304=>{:key=>"MagicalFootwear", :icon=>"perk-images/Styles/Inspiration/MagicalFootwear/MagicalFootwear.png"}, 
                                            8306=>{:key=>"HextechFlashtraption", :icon=>"perk-images/Styles/Inspiration/HextechFlashtraption/HextechFlashtraption.png"}, 
                                            8313=>{:key=>"PerfectTiming", :icon=>"perk-images/Styles/Inspiration/PerfectTiming/PerfectTiming.png"}, 
                                            8316=>{:key=>"MinionDematerializer", :icon=>"perk-images/Styles/Inspiration/MinionDematerializer/MinionDematerializer.png"}, 
                                            8321=>{:key=>"FuturesMarket", :icon=>"perk-images/Styles/Inspiration/FuturesMarket/FuturesMarket.png"}, 
                                            8326=>{:key=>"UnsealedSpellbook", :icon=>"perk-images/Styles/Inspiration/UnsealedSpellbook/UnsealedSpellbook.png"}, 
                                            8345=>{:key=>"BiscuitDelivery", :icon=>"perk-images/Styles/Inspiration/BiscuitDelivery/BiscuitDelivery.png"}, 
                                            8347=>{:key=>"CosmicInsight", :icon=>"perk-images/Styles/Inspiration/CosmicInsight/CosmicInsight.png"}, 
                                            8351=>{:key=>"GlacialAugment", :icon=>"perk-images/Styles/Inspiration/GlacialAugment/GlacialAugment.png"}, 
                                            8352=>{:key=>"TimeWarpTonic", :icon=>"perk-images/Styles/Inspiration/TimeWarpTonic/TimeWarpTonic.png"}, 
                                            8359=>{:key=>"Kleptomancy", :icon=>"perk-images/Styles/Inspiration/Kleptomancy/Kleptomancy.png"}, 
                                            8410=>{:key=>"ApproachVelocity", :icon=>"perk-images/Styles/Resolve/ApproachVelocity/ApproachVelocity.png"},                                            
                                          }
                                },
                        
                        8000 => {
                                :icon => "perk-images/Styles/7201_Precision.png",
                                :key => "Precision",
                                :runes => {
                                            8005=>{:key=>"PressTheAttack", :icon=>"perk-images/Styles/Precision/PressTheAttack/PressTheAttack.png"}, 
                                            8008=>{:key=>"LethalTempo", :icon=>"perk-images/Styles/Precision/FlowofBattle/FlowofBattleTemp.png"}, 
                                            8009=>{:key=>"PresenceOfMind", :icon=>"perk-images/Styles/Precision/LastResort/LastResortIcon.png"}, 
                                            8010=>{:key=>"Conqueror", :icon=>"perk-images/Styles/Precision/Conqueror/Conqueror.png"}, 
                                            8014=>{:key=>"CoupDeGrace", :icon=>"perk-images/Styles/Precision/CoupDeGrace/CoupDeGrace.png"}, 
                                            8017=>{:key=>"CutDown", :icon=>"perk-images/Styles/Precision/CutDown/CutDown.png"}, 
                                            8021=>{:key=>"FleetFootwork", :icon=>"perk-images/Styles/Precision/FleetFootwork/FleetFootwork.png"},
                                            9101=>{:key=>"Overheal", :icon=>"perk-images/Styles/Precision/Overheal.png"}, 
                                            9103=>{:key=>"LegendBloodline", :icon=>"perk-images/Styles/Precision/Legend_Infamy.png"}, 
                                            9104=>{:key=>"LegendAlacrity", :icon=>"perk-images/Styles/Precision/Legend_Heroism.png"}, 
                                            9105=>{:key=>"LegendTenacity", :icon=>"perk-images/Styles/Precision/Legend_Tenacity.png"}, 
                                            9111=>{:key=>"Triumph", :icon=>"perk-images/Styles/Precision/DangerousGame.png"},
                                            8299=>{:key=>"LastStand", :icon=>"perk-images/Styles/Sorcery/LastStand/LastStand.png"}
                                          }
                                },
                        
                        8100 => {
                                :icon => "perk-images/Styles/7200_Domination.png",
                                :key => "Domination",
                                :runes => {
                                            8105=>{:key=>"RelentlessHunter", :icon=>"perk-images/Styles/Domination/RelentlessHunter/RelentlessHunter.png"}, 
                                            8112=>{:key=>"Electrocute", :icon=>"perk-images/Styles/Domination/Electrocute/Electrocute.png"}, 
                                            8120=>{:key=>"GhostPoro", :icon=>"perk-images/Styles/Domination/GhostPoro/GhostPoro.png"}, 
                                            8124=>{:key=>"Predator", :icon=>"perk-images/Styles/Domination/Predator/Predator.png"}, 
                                            8126=>{:key=>"CheapShot", :icon=>"perk-images/Styles/Domination/CheapShot/CheapShot.png"}, 
                                            8128=>{:key=>"DarkHarvest", :icon=>"perk-images/Styles/Domination/DarkHarvest/DarkHarvest.png"}, 
                                            8134=>{:key=>"IngeniousHunter", :icon=>"perk-images/Styles/Domination/IngeniousHunter/IngeniousHunter.png"}, 
                                            8135=>{:key=>"RavenousHunter", :icon=>"perk-images/Styles/Domination/RavenousHunter/RavenousHunter.png"}, 
                                            8136=>{:key=>"ZombieWard", :icon=>"perk-images/Styles/Domination/ZombieWard/ZombieWard.png"}, 
                                            8138=>{:key=>"EyeballCollection", :icon=>"perk-images/Styles/Domination/EyeballCollection/EyeballCollection.png"}, 
                                            8139=>{:key=>"TasteOfBlood", :icon=>"perk-images/Styles/Domination/TasteOfBlood/GreenTerror_TasteOfBlood.png"}, 
                                            8143=>{:key=>"SuddenImpact", :icon=>"perk-images/Styles/Domination/SuddenImpact/SuddenImpact.png"}
                                          }
                                },
                                
                        8400 => {
                                :icon => "perk-images/Styles/7204_Resolve.png",
                                :key => "Resolve",
                                :runes => {
                                            8429=>{:key=>"Conditioning", :icon=>"perk-images/Styles/Resolve/Conditioning/Conditioning.png"}, 
                                            8437=>{:key=>"GraspOfTheUndying", :icon=>"perk-images/Styles/Resolve/GraspOfTheUndying/GraspOfTheUndying.png"},
                                            8439=>{:key=>"Aftershock", :icon=>"perk-images/Styles/Resolve/VeteranAftershock/VeteranAftershock.png"},
                                            8444=>{:key=>"SecondWind", :icon=>"perk-images/Styles/Resolve/SecondWind/SecondWind.png"}, 
                                            8446=>{:key=>"Demolish", :icon=>"perk-images/Styles/Resolve/Demolish/Demolish.png"}, 
                                            8451=>{:key=>"Overgrowth", :icon=>"perk-images/Styles/Resolve/Overgrowth/Overgrowth.png"}, 
                                            8453=>{:key=>"Revitalize", :icon=>"perk-images/Styles/Resolve/Revitalize/Revitalize.png"}, 
                                            8463=>{:key=>"FontOfLife", :icon=>"perk-images/Styles/Resolve/FontOfLife/FontOfLife.png"}, 
                                            8465=>{:key=>"Guardian", :icon=>"perk-images/Styles/Resolve/Guardian/Guardian.png"}, 
                                            8472=>{:key=>"Chrysalis", :icon=>"perk-images/Styles/Resolve/Chrysalis/Chrysalis.png"}, 
                                            8473=>{:key=>"BonePlating", :icon=>"perk-images/Styles/Resolve/BonePlating/BonePlating.png"},
                                            8242 => {:key => 'Unflinching', :icon => 'perk-images/Styles/Sorcery/Unflinching/Unflinching.png'}
                                          }
                                }  
                                
                        
                        }
                playerRunes = []
                payCheck = player_stats(matchId, championId)
                # puts slots[payCheck[:stats][:perkPrimaryStyle]]
                # puts slots[payCheck[:stats][:perkPrimaryStyle]][:runes][payCheck[:stats][:perk0]][:icon]
                # puts slots[payCheck[:stats][:perkSubStyle]][:icon]
                playerRunes.push(runes_icon(slots[payCheck[:stats][:perkPrimaryStyle]][:runes][payCheck[:stats][:perk0]][:icon]))
                playerRunes.push(runes_icon(slots[payCheck[:stats][:perkSubStyle]][:icon]))
                return playerRunes
            end
            
            private
            def runes_icon(pUrl)
                return "http://ddragon.leagueoflegends.com/cdn/img/#{pUrl}" 
            end
            
        end
        
    end
    
end