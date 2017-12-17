module ToolsHelper
	def elevator
		levels = []
		(1..24).each do |n|
			levels << n * 5
		end
		levels
	end

	def override
		levels = []
		(1..120).each do |level|
			if !(level % 40 > 5 && level % 40 < 30 && level % 40 != 19)
				levels << level
			end
		end
		levels
	end

	def monster(game_id, day)
		monster = []
		(1..119).each do |level|
			unless (elevator.include? level) || (override.include? level)
	  		rng = CsRandom.new(day + level + game_id / 2)
	  		monster << level if rng.next_double < 0.05 && rng.next_double < 0.5
	  	end
	  end
	  monster
	end

	def slime(game_id, day)
		slime = []
		(1..119).each do |level|
			unless (elevator.include? level) || (override.include? level)
	  		rng = CsRandom.new(day + level + game_id / 2)
	  		slime << level if rng.next_double < 0.05 && rng.next_double >= 0.5
	  	end
	  end
	  slime
	end

	def mushroom(game_id, day)
		mushroom = []
		(81..119).each do |level|
			unless elevator.include? level
				rng = CsRandom.new(day + level + game_id / 2)
				rng.next_double if rng.next_double < 0.3
				rng.next_double
				mushroom << level if rng.next_double < 0.035
			end
		end
		mushroom
	end
end
