module Civ

	@civs = Hash.new
	
	class << self
		def init(map)
			deviation = [-3, -2, -1, 0, 1, 2, 3]
			townlist = Array.new
			totalpop = 0
			MUNDANE_RACES.each { |race|
				LOG.puts "Processing civilization for %s" % race
				towns = Array.new
				cx = rand(20); cy = rand(10)
				LOG.puts "Center: (%s,%s)" % [cx, cy]
				(rand(3)+1).times do
					loc = [ cx+deviation[rand(7)], cy+deviation[rand(7)] ]
					while townlist.include? loc or loc[0] < 0 or loc[1] < 0 or \
						loc[0] >= 20 or loc[1] >= 10
						loc = [ cx+deviation[rand(7)], cy+deviation[rand(7)] ]
					end
					townlist.push loc
					name = Name.generate_city
					LOG.puts "%s city %s at (%s, %s)" % ([race, name]+loc)
					towns.push Town.new(race, name, loc)
				end
				@civs[race] = Civilization.new(race, towns)
			}
			puts "Towns: %s" % townlist.length
			@civs.each_pair { |race, civ|
				civ.towns.each { |town|
					tx, ty = town.location
					population = rand(450)+50
					population.times do
						totalpop += 1
						cx, cy = tx, ty
						if rand(2) == 0 then
							cx = tx + deviation[rand(5)+1]
							cy = ty + deviation[rand(5)+1]
							while cx < 0 or cy < 0 or cx >= 20 or cy >= 10
								cx = tx + deviation[rand(5)+1]
								cy = ty + deviation[rand(5)+1]
							end
						end
						map[cy][cx].push Creature.new(Name.generate_base,
							town.race, rand(25), rand(20), rand(10)+1, 0, 0)
					end
				}
			}
			puts "Population: %s" % totalpop
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

