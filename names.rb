# RACE NAME STYLES
# Humans: normal phonetics
# Elves: more Fs and vowels, less Ts and Ss
# Terran: Primarily Vs, Ws, Ts, and longer names

# BEAST NAME STYLES
# Dragons: Short, D/X/Z/A/I-based names
# Titans: Long, E/O-based names
# Fury: Midlength

class Array; def rand
	return self[Kernel.rand(self.length)]
end; end

VOWLS = 'aeiou'.split('')
CONST = 'bcdfghjklmnpqrstuvwxyz'.split('')
ALPHA = VOWLS + CONST

def generate_name_for_a(type=:human)
	case type
		when :human
			generate_human_name
		when :elf
			generate_human_name
			#generate_elven_name
		when :terran
			generate_human_name
			#generate_terran_name
		when :dragon
			generate_human_name
			#generate_dragon_name
		when :titan
			generate_human_name
			#generate_titan_name
		when :fury
			generate_human_name
			#generate_fury_name
	end
end

def generate_human_name
	name = ALPHA.rand + ALPHA.rand
	len = rand(10)+1
	i = 1
	len.times do
		last = name[i]
		second = name[i-1]
		if CONST.include? last and CONST.include? second then
			name += VOWLS.rand
		elsif VOWLS.include? last and VOWLS.include? second then
			name += CONST.rand
		else
			name += ALPHA.rand
		end
	end
	return name.capitalize
end

def generate_elven_name
end

def generate_terran_name
end

def generate_dragon_name
end

def generate_titan_name
end

def generate_fury_name
end
