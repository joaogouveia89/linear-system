class Fraction

	def initialize(numerator, denominator = 1)
		if denominator === 0
			raise "Denominator cannot be zero"
		end
		@numerator = numerator
		@denominator = denominator
	end

	attr_reader :numerator
	attr_reader :denominator

	def +(other)
		if other.instance_of? Fraction
			Fraction.new(
				@denominator * other.numerator + other.denominator * @numerator,
				other.denominator * @denominator 
				)
		else
			self + Fraction.new(other)
		end
	end

	def -(other)
		if other.instance_of? Fraction
			Fraction.new(
				other.denominator * @numerator - @denominator * other.numerator,
				other.denominator * @denominator 
				)
		else
			self - Fraction.new(other)
		end
	end

	def *(other)
		if other.instance_of? Fraction
			Fraction.new(
				(@numerator * other.numerator),
				(@denominator * other.denominator)
				)
		else
			self * Fraction.new(other)
		end
	end

	def /(other)
		if other.instance_of? Fraction
			f = Fraction.new(other.denominator, other.numerator)
			self * f
		else
			self / Fraction.new(other)
		end
	end

	def to_d
		(@numerator/denominator.to_f)
	end

	def simplify
		gdc = euclidGreatterCommonDivisor @numerator, @denominator
		Fraction.new(@numerator/gdc, @denominator/gdc)
	end

	def to_s
		@numerator.to_s + "/" + @denominator.to_s
	end

	private

	def euclidGreatterCommonDivisor a, b
		if a == 0
			aux = a
			a = b
			b = aux
		end
		return (b === 0) ? a : euclidGreatterCommonDivisor(b, a % b)
	end
end