def new_age(oldcount, data)
	nonfury = 0; nontitan = 0; nondragon = 0;
	(CTypes - [:fury]).each { |t| nonfury += data[t] }
	(CTypes - [:titan]).each { |t| nontitan += data[t] }
	(CTypes - [:dragon]).each { |t| nondragon += data[t] }
	return "Age of Furies" if data[:fury] > nonfury
	return "Age of Dragons" if data[:dragon] > nondragon
	return "Age of Titans" if data[:titan] > nontitan
	return "Age of "+data[:kill_leader].name+" the "+data[:kill_leader].type.to_s.capitalize if data[:kill_leader].kills > 2
	return "Demonic Age" if data[:mundane] < 1
	return "Golden Age" if data[:mythical] < 1
	return "Age of Chaos" if data[:mundane] > 50 and data[:mythical] > 50
	return "Age of Myths" if data[:mythical] > data[:mundane]
	return "Age of Mortals" if data[:mundane] > data[:mythical]
end
