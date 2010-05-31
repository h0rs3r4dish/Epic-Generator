=begin
Map data: 12x12 array of cells. Each cell is a square of land, one of 3 types:
	0 -> plains
	1 -> mountains
	2 -> river/water
=end

def generate_map
	map = Array.new(12)
	map.map { Array.new(12).each { |cell| 0 } } # Initialize with all plains
	return map
end

def print_map arr
	letters = '.^~'.split('')
	arr.each { |row|
		arr.each { |col|
			print letters[col]
		}
		print "\n"
	}
end
