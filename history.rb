require "lib/creature"
require "lib/map"
require "lib/names"
require "lib/civilizations"

$flag_color = false
$flag_maxyear = 500

ARGV.each { |arg|
	case arg
		when '--color'
			$flag_color = true
		when /\-\-year=([0-9]+)/
			$flag_maxyear = $1.to_i
	end
}

$map = Map.generate

Map.display $map

def tick
	return rand(10)
end

month = 0
event_count = 0

while (month / 12) < $flag_maxyear
	event_count += tick
	month += 1
end
puts "Year: %s" % (month / 12)
puts "Events: %s" % event_count
