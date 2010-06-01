module Civ

	@civs = Hash.new
	
	class << self
		def init(map)
			deviation = [-3, -2, -1, 0, 1, 2, 3]
			townlist = Array.new
			MUNDANE_RACES.each { |race|
				LOG.puts "Processing civilization for %s" % race
				towns = Array.new
				cx = rand(20); cy = rand(10)
				LOG.puts "Center: (%s,%s)" % [cx, cy]
				(rand(3)+1).times do
					loc = [ cx+deviation[rand(7)], cy+deviation[rand(7)] ]
					while townlist.include? loc
						loc = [ cx+deviation[rand(7)], cy+deviation[rand(7)] ]
					end
					townlist.push loc
					name = Name.generate_city
					LOG.puts "%s city %s at (%s, %s)" % ([race, name]+loc)
					towns.push Town.new(race, name, loc)
				end
				@civs[race] = Civilization.new(race)
			}
		end
	end
	
	class Civilization
		attr_reader :race
		attr_accessor :towns, :attitudes, :armies

		def initialize(race=:human, towns=[], attitudes={}, armies=[])
			@race = race
			@towns = towns
			@attitudes = attitudes
			@armies = armies
		end
	end


	class Town
		attr_reader :race, :name, :location
		
		def initialize(race=:human, name='', location=[0,0])
			@race = race
			@name = name
			@location = location
		end
	end


	class Army
		
	end
	
end

