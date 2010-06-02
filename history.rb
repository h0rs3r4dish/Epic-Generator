require "lib/creature"
require "lib/map"
require "lib/names"
require "lib/civilizations"

$flag_color    = false
$flag_maxyear  = 500
$flag_outdir   = "out/"
$flag_logfile  = "history.log"
$flag_histfile = "world_history.txt"

ARGV.each { |arg|
	case arg
		when '--color'
			$flag_color = true
		when /\-\-year=([0-9]+)/
			$flag_maxyear = $1.to_i
		when /\-\-logfile=(.+)/
			$flag_logfile = $1
		when /\-\-outdir=(.+)/
			$flag_outfile = $1
		when /\-\-histfile=(.+)/
			$flag_histfile = $1
	end
}

Dir.mkdir $flag_outdir if not Dir.exist? $flag_outdir

LOG = File.new(File.join($flag_outdir, $flag_logfile), 'w')

terrain = History::Terrain.new
terrain.display

$map = History::Terrain.blank.map { |row| row.map { Array.new } }

namegen = History::NameGen.new
civilizations = History::Civilizations.new $map, namegen
terrain.display civilizations.civs

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

LOG.close
