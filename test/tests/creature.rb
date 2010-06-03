load "lib/creature.rb"

test "Creature class" do

	shouldprops = {
		'name' => 'Doberman Macbeth',
		'race' => :terran,
		'attack' => rand(25)+5,
		'defense' => rand(20)+5,
		'hp' => rand(10)+1,
		'kills' => rand(30)+1,
		'legend' => rand(200)+1
	}

	c = History::Creature.new
	assert c.name == ''
	assert c.race == :human
	assert c.attack == 0
	assert c.defense == 0
	assert c.hp == 1
	assert c.kills == 0
	assert c.legend == 0

	shouldprops.each { |property, value|
		c.send((property+'=').intern, value)
	}
	shouldprops.each { |property, value|
		assert c.send(property.intern) == value
	}

end
