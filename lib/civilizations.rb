class Civilization
	
	attr_accessor :race, :towns, :attitudes, :armies

	def initialize(race=:human, towns=[], attitudes={}, armies=[])
		@race = race
		@towns = towns
		@attitudes = attitudes
		@armies = armies
	end

end


class Town

end


class Army

end
