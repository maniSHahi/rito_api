# RitoApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rito_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rito_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rito_api

## Usage

Create a client. You can declare whether to cache it or not. Caching is consider more productive. 
*Only supports Redis caching so you need to run redis server before declaring cache as true.

```rb
client = RitoApi::Client(api_key, region, true, 180) # client = RitoApi:Client(api_key, region, cache[true or false], ttl[time till expiration in seconds]). 
# By default caching is set to false.
```
There are 5 kinds of public readable request formats. summoner, champion, item, match, challenger

Challenger:
```rb
challengers = client.challenger.solo_queue(count, ttl) # Yes you can modify ttl for every method to overwrite the initial ttl.
# Count will give back that number of results from the 200 challenger result. If you put down name or number <= 0 and > 200 it will return all 200 results.
#Example:
top5chalengers = client.challengers.solo_queue(5, 3600) # This will give you top 5 challengers and save the challengers in the cache for 60 minutes.
```
Summoner:
```rb
    #find(IGN) => Find the summoner for given IGN.
    mySummoner = client.summoner.find('rockerturner') # you can pass ttl as second argument but by default it will use the initialized ttl which is 180 here.
    
    #rank_info => returns rank information for given IGN. if not ranked on any queue; should return nil or {}.
    myRank = client.summoner.rank_info('rockerturner') 
    
    #solo, flex, tt => will use rank_info to get queried rank.
    mySoloRank = client.summoner.solo('rockerturner')
    myFlexRank = client.summoner.flex('rockerturner')
    myTwistedTreeRank = client.summoner.tt('rockerturner')
    
    #recent_matches => returns 20 recent matches fragment data of given IGN.
    myRecentMatches => client.summoner.recent_matches('rockerturner')
    
    #top_positions => return 2 top position played by the summoner in last 20 matches of given IGN.
    myTopPositions = client.summoner.top_positions('rockerturner')
    
    #champion_mastery => returns all the champion mastery for given ign with mastery level and points. You can pass in second argument of count to get top count mastery.
    myTop3Masteries = client.summoner.champion_mastery('rockerturner', 3)
    
    #icon => return icon link of the given iconID.
    myIcon = client.summoner.icon(iconId) # You can get iconID from metadata of find(ign).
    #Example:
    rockerturner_icon = client.summoner.icon(mySummoner[:profileIconId]) #mySummoner was defined earlier.
```
Champion:
```rb
#Champion calls are relatively easy.

#get_name => gets the name of given champion ID.
championName = client.champion.get_name('43') # Returns Karma. 

#Lets make real use of this.

myTop3Masteries.each do |champion|
    puts client.champion.get_name(champion[:championId]) #This is print out the name of myTop3Masteries champions.
end

#icon => gets the icon link for the given champion.

vayneIcon = client.champion.icon('Vayne') #casesensitive. wukong is MonkeyKing

#points => just gives K or M depending on the points sent in. 

myPoints = client.champion.points(500000) # Will return 500K

#Lets make real use of this.

myTop3Masteries.each do |champion|
    puts "#{client.champion.get_name(champion[:championId])} = #{client.champion.points(champion[:championPoints])}" 
    #This is print out the name = masteryPoints of myTop3Masteries champions.
end
```
#match
```rb
#get => gets match information.
myMatch = client.matches.get(matchId) # You can get a matchID from summoner.recent_matches.
rockerturnerMatch = client.matches.get(2769842762) # This is one of my matches. We will be using it as an example for rest of the methods.

#get_bans => gets all the banned championId. Separated into 2 arrays for blue and red team.
rockerturnerMatchBans = client.matches.get_bans(2769842762)

#get_players => gets all the players in the match with their ign and id and iconId etcetera.
rockerturnerMatchPlayers = client.matches.get_players(2769842762)

#stats => gets the stats of the game.
rockerturnerMatchStats = client.matches.stats(2769842762)

#player_stats => returns players stats playing certain champion.
#I played karma this game and champion ID for karma is 43. you can find champID in meta data of get_players.
rockerturnerStats = client.matches.player_stats(2769842762, 43)

#player_identities => returns the player identity from the participant ID which can be obtained from get_players or stats or player_stats.
#My participantId this game was 2.
rockerturnerIdentities = client.matches.player_identities(2769842762, 2)
```

#item
```rb
#get_icon => returns link for given item id.
ardentIcon = client.item.get_icon(3504)

#spells_icon(id)
flashIcon = client.item.spells_icon(4)
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rito_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RitoApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rito_api/blob/master/CODE_OF_CONDUCT.md).
