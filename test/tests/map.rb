require "lib/map.rb"

test "Terrain class" do

	def assert_map_length m
		assert m.length == 10
		m.each { |r| assert r.length == 20 }
	end

	b = History::Terrain.blank
	t = nil

	assert_map_length b
	silently do
		t = History::Terrain.new
	end
	assert t.class.to_s == "History::Terrain"
	assert_map_length t.terrain
	assert_error { t.terrain = b }
	assert_not_error { silently { t.generate } }
	assert_not_error { silently { t.display } }

end
