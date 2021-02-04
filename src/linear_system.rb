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
	puts("0 0 0")
	puts("0.05")
	puts("************************")
	puts("choose numeric method: You can choose with which Linear System numeric method you want your solution(Elimination, Gauss Jacobi, Gauss Seidl, ect...), by setting a flag with the method id. The options are:")
	puts("--elimination")
	puts("--gauss-jacobi")
	puts("--gauss-seidl")
	puts("The default method is elimination or if you has put in the input error value AND initial approaches array the default method will be gauss-jacobi")
end

selected_method = :elimination
defined_method_by_flag = false

for arg in ARGV
   if ARGV.size === 1
   	case arg
   	when "--help"
   		linear_system_help
   		return
   	when "--elimination"
   		selected_method = :elimination
   		defined_method_by_flag = true
   	when "--gauss-jacobi"
   		selected_method = :gauss_jacobi
   		defined_method_by_flag = true
   	when "--gauss-seidl"
   		selected_method = :gauss_seidl
   		defined_method_by_flag = true
   	end

   	else return
   end
end

#input parsing and reading
input00 = File.open("../test-cases/input/input.txt")

data = input00.map(&:chomp) #removing the new line characters

last_line = data.last.split(" ")
if last_line.size > 1
	nofvar = data.size
	has_errors_and_approach = false
else
	nofvar = data.size - 2
	has_errors_and_approach = true
	unless defined_method_by_flag
		selected_method = :gauss_jacobi
	end	
end

linear_system = []
approaches = []
error = 0
data.each.with_index do |line, idx|
	splitted = line.split(" ")
	if((has_errors_and_approach && (idx < nofvar)) && splitted.size - 1 > nofvar) || !has_errors_and_approach && splitted.size - 1 > nofvar
		raise "Invalid linear system"
	end
	splitted.map do |el|
		if has_errors_and_approach
			if idx == data.size - 1
				unless el.match?(/[[:digit:]]?(\.)[[:digit:]]+/) && splitted.size == 1
					raise "The last line of the file corresponds to the error value, it must be a single value and it must be a float number like 0.005, or you can use .005"
				end
				error = el.to_f
			elsif idx == data.size - 2
				unless el.match?(/[[:digit:]]?(\.)[[:digit:]]+/) && splitted.size == nofvar
					raise "The line before the last line must contain the approaches, they must be float numbers and the number of approaches must be the same as the number of variables"
				end
				approaches << el.to_f
			else
				unless el.match?(/[[:digit:]]/)
					raise "Invalid element '" + el + "', you must use only integer numbers"
				end
				linear_system << Fraction.new(el.to_i)
			end
		else
			unless el.match?(/[[:digit:]]/)
				raise "Invalid element '" + el + "', you must use only integer numbers"
			end
			linear_system << Fraction.new(el.to_i)
		end		
	end
end

# problem application
start = Time.now
lsm = LinearSystemMethod.new(linear_system, nofvar, approaches, error)
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