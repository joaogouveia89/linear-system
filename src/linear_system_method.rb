class LinearSystemMethod

	def initialize linear_system, nofvar
		@linear_system = linear_system
		@nofvar = nofvar
	end
	def gauss_elimination
		original_system = @linear_system.map(&:clone)
		pivot_line = 0
		pivot_column = 0

		
	end


	private
	def get_element line, column
		element = -1
		unless line >= @nofvar || column > (@nofvar + 1)
			element = (@nofvar + 1) * line + column
		end
		element
	end
end