require './fraction'
require './linear_system_method'

def linear_system_help
	puts("Linear System Help")
	puts("-------------------------")
	puts("Input pattern:")
	puts("The input must contain a matrix in the linear system format JUST WITH THE NUMBERS. If you have an error value or initial approach values you must put them under this matrix in a new line for each data.")
	puts("It's mandatory to assign multipliers for each variable in the matrix, otherwise it will be invalid, if one of the variable has no multipliers, assign it with 0 in the matrix")
	puts("Example 1: Just the matrix: ")
	puts("3 2 4 1")
	puts("1 1 2 2")
	puts("4 3 -2 3")
	puts("Example 2: Matrix + error + initial approaches: ")
	puts("3 2 4 1")
	puts("1 1 2 2")
	puts("4 3 -2 3")
	puts("0.05")
	puts("0 0 0")
	puts("************************")
	puts("choose numeric method: You can choose with which Linear System numeric method you want your solution(Elimination, Gauss Jacobi, Gauss Seidl, ect...), by setting a flag with the method id. The options are:")
	puts("--elimination")
	puts("--gauss-jacobi")
	puts("--gauss-seidl")
	puts("The default method is elimination or if you has put in the input error value AND initial approaches array the default method will be gauss-jacobi")
end

selected_method = :elimination

for arg in ARGV
   if ARGV.size === 1
   	case arg
   	when "--help"
   		linear_system_help
   		return
   	when "--elimination"
   		selected_method = :elimination
   	when "--gauss-jacobi"
   		selected_method = :gauss_jacobi
   	when "--gauss-seidl"
   		selected_method = :gauss_seidl
   	end

   	else return
   end
end

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
		linear_system << Fraction.new(el.to_i)
	end
end

# problem application
start = Time.now
lsm = LinearSystemMethod.new(linear_system, nofvar)
case selected_method
when :elimination
	lsm.gauss_elimination
when :gauss_jacobi
	lsm.gauss_jacobi
when :gauss_seidl
	lsm.gauss_seidl
end

finish = Time.now

puts("solved all the test cases in " + (1000 * (finish - start)).round(2).to_s + "ms")

puts "Solution = " + lsm.get_results_to_d.to_s