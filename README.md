Epic Generator
==============

Let's make history!

It's a rather complex way of doing things, but this application generates a
world and then proceeds to populate it. This population, a mix of the semi-normal
(humans, elves, and Terran, which I made up) and the demonic (Furies, dragons,
and titans) then weaves a story: waging war, expanding, dying, farming... in
short, this is a civilization sim.

Unit Tests
----------

There are a couple. The framework code lives in `test/test.rb`, and it is run
with the following command:

	$ ruby test/test.rb [testname]

Where `testname` is either the name of a test (`test/tests/[testname].rb`) or
just `all` (the default)
