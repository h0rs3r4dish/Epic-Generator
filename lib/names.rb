module Name

	@relations = Hash.new
	@startpairs = Array.new
	
	class << self
	
		def init
			namelist = IO.readlines('data/names.txt').map { |l| l.strip.downcase }
			namelist.each { |name|
				loc = 0
				@startpairs.push( name[loc] + name[loc+1] )
				while name.length > loc+3
					firstpair = name[loc] + name[loc+1]
					secondpair = name[loc+2]
					secondpair += name[loc+3] if name.length > loc+4
					@relations[firstpair] ||= Array.new
					@relations[firstpair].push secondpair
					loc += 1
				end
			}
		end

		def generate_base min_length=-1
			min_length = rand(8)+3 if min_length == -1
			word = @startpairs[rand(@startpairs.length)]
			wl = word.length
			while wl < min_length
				choices = @relations[word[wl-2]+word[wl-1]]
				word += choices[rand(choices.length)]
				wl = word.length
			end
			return word.capitalize
		end
	
		def generate_city
	
		end
	
		def generate_river
	
		end
	
		def generate_mountain
	
		end
		
	end

end
