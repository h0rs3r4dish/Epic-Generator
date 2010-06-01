=begin
Map data: 12x12 array of cells. Each cell is a square of land, one of 3 types:
	0 -> plains
	1 -> mountains
	2 -> river/water
=end

module Map; class << self

	def init
		return [[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
			  	[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ],
				[ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ]]
	end

	def generate
		map = init
		mountains = 0.0
		mount_threshold = (((rand % 25) * 25) + 5) / 100.0
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
		end
		
		puts "Mountain coverage: %02d%%" % (percent * 100)
		
		rivermax = rand(4)+2
		puts "Rivers: #{rivermax}"
		rivermax.times do |i|
			sx = rand(17)+1; sy = rand(7)+1; dir = :none
			while dir == :none
				if map[sy][sx] == 0 then
					dir = :down if map[sy-1][sx] == 1
					dir = :up if map[sy+1][sx] == 1
					dir = :right if map[sy][sx-1] == 1
					dir = :left if map[sy][sx+1] == 1
				end
				if dir == :none then
					sx = rand(17)+1; sy = rand(7)+1;
				end
			end
			lastturn = true
			cx = sx; cy = sy
			while cx >= 0 and cy >= 0 and cx < 20 and cy < 10
				map[cy][cx] = 2
				lastturn = (rand > 0.5) if not lastturn
				if lastturn then
					case dir
						when :up
							cy -= 1
						when :down
							cy += 1
						when :left
							cx -= 1
						when :right
							cx += 1
					end
					lastturn = false
				else
					if dir == :up or dir == :down then
						cx += (rand > 0.5) ? 1 : -1
					else
						cy += (rand > 0.5) ? 1 : -1
					end
					lastturn = true		
				end
			end
		end
		
		return map
	end

	def display arr
		letters = '.^~'.split('')
		escapes = [ '', '', '' ]
		if $flag_color then
			escapes = "\033[32;2m \033[37;2m \033[34;1m".split(' ')
		end
		arr.each { |row|
			row.each { |col|
				print escapes[col]+letters[col]
			}
			print "\n"
		}
		print "\033[m" if $flag_color
	end

end; end
