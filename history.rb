require 'names'
require 'age'

Creature = Struct.new :name, :type, :atk, :def, :hp, :kills do
	def initialize(nm='', type=:human, atk=0, defe=0, hp=0, kills=0)
		self.name = name; self.type  = type
		self.atk  = atk;  self.def   = defe
		self.hp   = hp;   self.kills = kills
	end
end

CTypes = [ :human, :elf, :terran, :titan, :dragon, :fury ]
MTypes = [ :human, :elf, :terran ]
Dirs   = %w{north south east west}.map { |dir| dir.intern }.sort

def mundane?(type)
	MTypes.include? type
end

def fight!(a, b)
	#puts "%s (%s) fights %s (%s)" % [a.name, a.type, b.name, b.type]
	a_hp = a.hp
	b_hp = b.hp
	while a_hp > 0 and b_hp > 0
		a_atk = rand(a.atk)
		a_def = rand(a.def)
		b_atk = rand(b.atk)
		b_def = rand(b.def)
		b_hp -= (a_atk - b_def) if a_atk > b_def
		a_hp -= (b_atk - a_def) if b_atk > a_def
	end
	return a if a_hp > 0
	return b
end

the_land = {
	:east => Array.new,
	:west => Array.new,
	:south => Array.new,
	:north => Array.new
}

count = { :total => 0, :mundane => 0, :human => 0, :elf => 0, :terran => 0,
	:mythical => 0, :titan => 0, :dragon => 0, :fury => 0 }

$age = ''
done = Array.new

Dirs.each do |area|
	len = rand(191)+10
	count[:total] += len
	len.times do
		c = Creature.new
		c.type = CTypes.rand
		count[c.type] += 1
		c.name = generate_name_for_a c.type
		if mundane? c.type then
			count[:mundane] += 1
			c.atk = rand(25) + 1
			c.def = rand(20) + 1
			c.hp  = rand(10) + 1
		else
			count[:mythical] += 1
			c.atk = rand(81) + 20
			c.def = rand(67) + 20
			c.hp  = rand(41) + 10
		end
		c.kills = 0
		the_land[area].push c
	end
end

puts "%d creatures generated:\n\t%d mundane (%d Humans, %d Elves, %d Terran)\n\t%d mythical (%d Dragons, %d Titans, %d Furies)." % count.values

data = { :kill_leader => Creature.new, :north_leader => Creature.new,
	:south_leader => Creature.new, :east_leader => Creature.new,
	:west_leader => Creature.new, :mythical => count[:mythical],
	:mundane => count[:mundane], :human => count[:human], :elf => count[:elf],
	:terran => count[:terran], :total => count[:total], :fury => count[:fury],
	:titan => count[:titan], :dragon => count[:dragon] }

nage = new_age(count, data)
if $age != nage then
	puts nage
	$age = nage
end

while data[:total] > 4
	Dirs.each do |area|
		list = the_land[area]
		winners = Array.new
		if list.length == 1 then
			if not done.include? area then
				w = list[0]
				data[(area.to_s+'_winner').intern] = w
				done.push area
				#puts "%s (%s) is champion of the %s" % [w.name, w.type, area]
			end
			next
		end
		i = 0
		while i < list.length
			if i+1 < list.length then
				a = list[i]; b = list[i+1]
				w = fight! a, b
				w.kills += 1
				winners << w
				data[:kill_leader] = w if w.kills > data[:kill_leader].kills
				if w == a then
					data[a.type] -= 1 
					if mundane? a.type then
						data[:mythical] -= 1
					else
						data[:mundane] -= 1
					end
				else
					data[b.type] -= 1 
					if mundane? b.type then
						data[:mythical] -= 1
					else
						data[:mundane] -= 1
					end
				end
				data[:total] -= 1
			end
			i += 2
		end
		the_land[area] = winners
	end
	nage = new_age(count, data)
	if $age != nage then
		puts nage
		$age = nage
	end
	break if done.sort == Dirs
end
