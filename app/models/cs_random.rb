class CsRandom < ApplicationRecord
	attr_accessor :inext, :inextp, :seed_array

	# Constants
	INT_MIN = -2147483648
	INT_MAX = 2147483647
	MBIG = INT_MAX
	MSEED = 161803398
	
	def initialize(seed)
		@seed_array = []

	  subtraction = (seed == INT_MIN) ? INT_MAX : seed.abs
	  mj = MSEED - subtraction
	  seed_array[55] = mj
	  mk = 1

	  (1..54).each do |i|
	  	ii = (21 * i) % 55
	  	seed_array[ii] = mk
	  	mk = mj - mk
	  	mk += MBIG if mk < 0
	  	mj = seed_array[ii]
	  end

	  (1..4).each do |k|
	  	(1..55).each do |i|
	  		seed_array[i] -= seed_array[1 + (i + 30) % 55]
	  		seed_array[i] += MBIG if seed_array[i] < 0
	  	end
	  end

	  @inext = 0
	  @inextp = 21
	end

	def sample
		internal_sample * ( 1.0 / MBIG )
	end

	def internal_sample
		locINext = @inext
		locINextp = @inextp

		locINext += 1
		locINextp += 1

		if locINext >= 56
			locINext = 1
		end

		if locINextp >= 56
			locINextp = 1 
		end

		return_value = seed_array[locINext] - seed_array[locINextp]

		if return_value == MBIG
			return_value -= 1
		end

		if return_value < 0
			return_value += MBIG
		end

		seed_array[locINext] = return_value

		@inext = locINext
		@inextp = locINextp

		return_value
	end

	# def get_sample_for_large_range
	# 	result = internal_sample
	# 	if internal_sample % 2 === 0
	# 		result = -result
	# 	end

	# 	d = result
	# 	d += (INT_MAX - 1)
	# 	d /= 2 * INT_MAX - 1
	# 	d
	# end

	def next(*args)
		a, b = *args
		min = 0
		max = INT_MAX

		if b.is_a? Integer
			raise ArgumentError, "Argument out of range" if a > b
			max = b
			min = a if a.is_a? Integer

			range = max - min
			if range <= INT_MAX
				(sample * range + min).to_i 
			else
				#get_sample_for_large_range * range + min
			end
		elsif a.is_a? Integer
			raise ArgumentError, "Argument out of range" if a < 0
			max = a
			(sample * max).to_i 
		else
			internal_sample
		end
	end

	def next_double
		sample
	end
end
