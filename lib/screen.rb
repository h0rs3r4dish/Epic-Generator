def move_cursor_up n=1; print "\033[#{n}A"; end
def move_cursor_down n=1; print "\033[#{n}B"; end
def move_cursor_right n=1; print "\033[#{n}C"; end
def move_cursor_left n=1; print "\033[#{n}D"; end

def putch x,y,c
	print "\033[#{y};#{x}H#{c}"
end
