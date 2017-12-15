class ToolsController < ApplicationController
  def index
  end

  def mines
  	@elevator = []
  	@override = []
  	@monster = []
  	@slime = []
  	@mushroom = []

  	# Temporary Numbers for testing
  	id = 123456789
  	day = 1

  	#Elevators every 5 levels
  	(6..119).each do |level|
  		if level % 5 == 0 
  			@elevator << level
  		elsif !(level % 40 > 5 && level % 40 < 30 && level % 40 != 19)
  			@override << level
  		end

  		# Infestation Checks
  		unless @elevator.include? level
  			unless @override.include? level
		  		rng = CsRandom.new(day + level + id / 2)
		  		if rng.next_double < 0.05
		  			if rng.next_double < 0.5
		  				@monster << level
		  			else
		  				@slime << level
		  			end
		  		end
		  	end

	  		# Mushroom Level Check. Reset RNG
	  		if level > 80
	  			rng = CsRandom.new(day + level + id / 2)

	  			# Game uses rng for lighting checks
	  			if rng.next_double < 0.3
	  				rng.next_double
	  			end
	  			rng.next_double

	  			if rng.next_double < 0.035
	  				@mushroom << level
	  			end

	  			#
	  		end
	  	end


  	end
  	
  end
end
