=begin
Map data: 10x20 array of cells. Each cell is a square of land, one of 3 types:
	0 -> plains
	1 -> mountains
	2 -> river/water
=end

def generate_map
	map = [ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ], ]
	mountains = 0.0
	mount_threshold = (((rand % 25) * 25) + 5) / 100.0
	while (mountains / 200) < mount_threshold
		th = rand(4) + 1; bh = rand(4) + 1; lw = rand(4) + 1; rw = rand(4) + 1
		centerx = rand(10); centery = rand(10);
		while map[centery][centerx] == 1
			centerx = rand(20); centery = rand(10); # No repeat centers
		end
		
		map[centery][centerx] = 1 # Set the center
		mountains += 1
		((centerx)..(centerx-th)).each { |i|
			next if i < 0; map[centery][i] = 1; mountains += 1
			(centery)..(centery-(rand(4)+1)).each { |j|
				next if j < 0; map[j][i] = 1; mountains += 1
			}
			(centery)..(centery+(rand(4)+1)).each { |j|
				next if j < 0; map[j][i] = 1; mountains += 1
			}
		}
		((centerx+1)..(centerx+bh)).each { |i|
			next if i >= 20; map[centery][i] = 1; mountains += 1
			next if i < 0; map[centery][i] = 1; mountains += 1
			(centery)..(centery-(rand(4)+1)).each { |j|
				next if j < 0; map[j][i] = 1; mountains += 1
			}
			(centery)..(centery+(rand(4)+1)).each { |j|
				next if j < 0; map[j][i] = 1; mountains += 1
			}
		}
		((centery-1)..(centery-lw)).each { |i|
			next if i < 0; map[i][centerx] = 1; mountains += 1
		}
		((centery+1)..(centery+rw)).each { |i|
			next if i >= 10; map[i][centerx] = 1; mountains += 1
		}
	end
	return map
end

def print_map arr
	letters = '.^~'.split('')
	arr.each { |col|
		col.each { |row|
			print letters[row]
		}
		print "\n"
	}
end
