=begin
Map data: 12x12 array of cells. Each cell is a square of land, one of 3 types:
	0 -> plains
	1 -> mountains
	2 -> river/water
=end

require "lib/screen"

module Map; class << self

	def generate
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
		print "Mountain coverage: 00%"
		percent = (mountains / 200)
		while percent < mount_threshold
			th = rand(4) + 1; bh = rand(4) + 1; lw = rand(4) + 1; rw = rand(4) + 1
			centerx = rand(10); centery = rand(10);
			while map[centery][centerx] == 1
				centerx = rand(20); centery = rand(10); # No repeat centers
			end
		
			map[centery][centerx] = 1 # Set the center
			mountains += 1
			((centerx)..(centerx-th)).each { |i|
				next if i < 0; map[centery][i] = 1; mountains += 1
				((centery)..(centery-(rand(4)+1))).each { |j|
					next if j < 0; map[j][i] = 1; mountains += 1
				}
				((centery)..(centery+(rand(4)+1))).each { |j|
					next if j >= 10; map[j][i] = 1; mountains += 1
				}
			}
			((centerx+1)..(centerx+bh)).each { |i|
				next if i >= 20; map[centery][i] = 1; mountains += 1
				next if i < 0; map[centery][i] = 1; mountains += 1
				((centery)..(centery-(rand(4)+1))).each { |j|
					next if j < 0; map[j][i] = 1; mountains += 1
				}
				((centery)..(centery+(rand(4)+1))).each { |j|
					next if j >= 10; map[j][i] = 1; mountains += 1
				}
			}
			((centery-1)..(centery-lw)).each { |i|
				next if i < 0; map[i][centerx] = 1; mountains += 1
			}
			((centery+1)..(centery+rw)).each { |i|
				next if i >= 10; map[i][centerx] = 1; mountains += 1
			}
			
			percent = (mountains / 200)
			move_cursor_left 3; print "%02d%%" % (percent * 100).to_i
		end
		
		puts
		
		rivermax = rand(4)+2
		rivermax.times do
		
		end
		
		return map
	end

	def display arr
		letters = '.^~'.split('')
		arr.each { |row|
			row.each { |col|
				print letters[col]
			}
			print "\n"
		}
	end

end; end
