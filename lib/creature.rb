RACEDATA = {
	:human => {
		:deathrate => 0.45,
		:birthrate => 0.60
	},
	:elf => {
		:deathrate => 0.45,
		:birthrate => 0.60
	},
	:terran => {
		:deathrate => 0.45,
		:birthrate => 0.60
	},
	:dragon => {
		:deathrate => 0,
		:birthrate => 0.05
	},
	:titan => {
		:deathrate => 0,
		:birthrate => 0.05
	},
	:fury => {
		:deathrate => 0,
		:birthrate => 0.05
	}
}

RACES = RACEDATA.keys

Creature = Struct.new(:name, :race, :age, :attack, :defense, :kills) do
	def initialize(name='',race=:human,age=1,attack=0,defense=0,kills=0)
		self.name    = name
		self.race    = race
		self.age     = age
		self.attack  = attack
		self.defense = defense
		self.kills   = kills
	end
end
