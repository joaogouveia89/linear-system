class LinearSystemMethod

	attr_reader :result

	def initialize linear_system, nofvar, error = 0, approaches = nil
		@linear_system = linear_system
		@nofvar = nofvar
		@result = []
		@error = error
		@approaches = approaches
	end
	def gauss_elimination
		original_system = @linear_system.map(&:clone)
		pivot_line = 0
		pivot_column = 0

		while pivot_line < @nofvar
			pivot = get_system_element(pivot_line, pivot_column)

			((pivot_line + 1)..@nofvar).each do |i|
				m = get_system_element(i, pivot_column) / pivot
				(0..@nofvar).each do |j|
					f = m * get_system_element(pivot_line, j)
					f = get_system_element(i, j) - f
					set_system_element i, j, f
				end
			end
			pivot_line = pivot_line + 1
			pivot_column = pivot_column + 1
		end

		(@nofvar - 1).downto(0) do |current_line|
			current_column = current_line
			sum = Fraction.new(0)

			if(@result.size > 0)
				(@nofvar - 1).downto(current_column + 1) do |j|
					sum = get_system_element(current_line, j) * @result[@nofvar - j - 1]
				end
			end

			res = (get_system_element(current_line, @nofvar) - sum) / get_system_element(current_line, current_column)
			res = res.simplify
			
			@result << res
		end

		@result.reverse!
	end

	def gauss_jacobi
		puts("gauss_jacobi")
	end

	def gauss_seidl
		puts("gauss_seidl")
	end


	def get_results_to_d
		@result.map(&:to_d)
	end


	private

	def set_system_element line, column, value
		@linear_system[get_element_id(line, column)] = value
	end

	def get_system_element line, column
		@linear_system[get_element_id(line, column)]
	end

	def get_element_id line, column
		element = -1
		unless line >= @nofvar || column > (@nofvar + 1)
			element = (@nofvar + 1) * line + column
		end
		element
	end
end

