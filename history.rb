require "lib/creature"
require "lib/map"
require "lib/names"

$flag_color = false

if ARGV.include? '--color' then
	ARGV.delete('--color')
	$flag_color = true
end

$map = Map.generate

Map.display $map
