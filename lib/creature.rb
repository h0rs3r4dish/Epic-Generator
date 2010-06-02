module History

RACEDATA = {
	:human => {
		:deathrate => 0.45,
		:birthrate => 0.60
	},
	:elf => {
		:deathrate => 0.30,
		:birthrate => 0.50
	},
	:terran => {
		:deathrate => 0.55,
		:birthrate => 0.70
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
MUNDANE_RACES = [ :human, :elf, :terran ]

Creature = Struct.new(:name, :race, :attack, :defense, :hp, :kills, :legend) do
	def initialize(name='',race=:human,attack=0,defense=0,hp=1,kills=0,legend=0)
		self.name    = name
		self.race    = race
		self.attack  = attack
		self.defense = defense
		self.hp      = hp
		self.kills   = kills
		self.legend  = legend
	end
end

end
