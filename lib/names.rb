module History

class NameGen
	
	def initialize
		@relations = Hash.new
		@startpairs = Array.new
		@city_postfixes = Array.new
		@river_postfixes = Array.new
		@mtn_postfixes = Array.new
		IO.readlines('data/names.txt').map { |l| l.strip.downcase }.each { |name|
			loc = 0
			@startpairs.push( name.slice(loc,2) )
			while name.length > loc+3
				firstpair = name.slice(loc,2)
				follower = name[loc+2].chr
				@relations[firstpair] ||= Array.new
				@relations[firstpair].push follower
				loc += 1
			end
		}
		@mnt_postfixes = IO.readlines('data/mnt_suffix.txt').map { |l| l.chomp }
		@river_postfixes = IO.readlines('data/river_suffix.txt').map { |l| l.chomp }
		@city_postfixes = IO.readlines('data/city_suffix.txt').map { |l| l.chomp }
	end

	def generate_base min_length=-1
		min_length = rand(8)+3 if min_length == -1
		word = @startpairs[rand(@startpairs.length)]
		wl = word.length
		while wl < min_length
			choices = @relations[word.slice(-2,2)]
			break if not choices
			word += choices[rand(choices.length)]
			wl = word.length
		end
		return word.capitalize
	end

	def generate_city
		return generate_base + @city_postfixes[rand(@city_postfixes.length)]
	end

	def generate_river
		return generate_base + @river_postfixes[rand(@river_postfixes.length)]
	end

	def generate_mountain
		return generate_base + @mnt_postfixes[rand(@mnt_postfixes.length)]
	end

end

end
