testname = ARGV.first || 'all'

STDOUT.sync = true

def test(desc, &block)
	result = :pass
	print desc
	begin; block.call
	rescue; result = :fail
	ensure; $_testcount[result] += 1
	end
end
def assert(bool, message='')
	bool ? _pass_assert : _fail_assert
end
def assert_not(bool, message='')
	bool ? _fail_assert : _pass_assert
end
def assert_error(message='', &block)
	begin; block.call
	rescue; _pass_assert
	else; _fail_assert
	end
end
def assert_not_error(message='', &block)
	begin; block.call
	rescue; _fail_assert
	else; _pass_assert
	end;
end
def silently(&block)
	def puts *a; end; def print *a; end; def p *a; end;
	block.call
	def puts *a; Kernel.puts *a; end
	def print *a; Kernel.print *a; end
	def p *a; Kernel.p *a; end
end
def _pass_assert
	print '.'; $_assertcount[:pass] += 1
end
def _fail_assert
	print 'f'; $_assertcount[:fail] += 1
end
def _print_assert_results
	asserttotal = $_assertcount[:pass] + $_assertcount[:fail]
	puts "\n%d/%d assertions passed (%d failed)" % [ $_assertcount[:pass], asserttotal,
		$_assertcount[:fail] ]
$_assertcount = { :pass => 0, :fail => 0 }
end
def _print_test_results
	testtotal = $_testcount[:pass] + $_testcount[:fail]
	puts "%d/%d tests passed (%d failed)" % [ $_testcount[:pass], testtotal,
		$_testcount[:fail] ]
	$_testcount = { :pass => 0, :fail => 0 }
end

$_testcount = { :pass => 0, :fail => 0 }
$_assertcount = { :pass => 0, :fail => 0 }

if testname == 'all' then
	ignorelist = if File.exist? 'test/tests/.ignore' then
		File.readlines('test/tests/.ignore').map { |l| l.strip }
	else
		Array.new
	end
	Dir['test/tests/*'].each { |file|
		next if ignorelist.include? file
		load file
		_print_assert_results
	}
else
	load "test/tests/%s.rb" % testname
	_print_assert_results
end
_print_test_results
