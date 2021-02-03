require './fraction'
require './linear_system_method'

#input parsing and reading
input00 = File.open("../test-cases/input/input.txt")

data = input00.map(&:chomp) #removing the new line characters
arr0 = data[0].split(" ").map(&:to_i)
nofvar = data.size
linear_system = []
data.each do |line|
	splitted = line.split(" ")
	if splitted.size - 1 > nofvar
		raise "Invalid linear system"
	end
	splitted.map do |el|
		unless el.match?(/[[:digit:]]/)
			raise "Invalid element '" + el + "', you must use only integer numbers"
		end
		linear_system << el.to_i
	end
end

# problem application
start = Time.now
LinearSystemMethod.gauss_elimination linear_system, nofvar
finish = Time.now

puts("solved all the test cases in " + (1000 * (finish - start)).round(2).to_s + "ms")

puts "Response = INPUT 05"