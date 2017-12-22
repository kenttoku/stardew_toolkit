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

	def cart_stock(game_id, day)
		stock = []
		items = Item.all
		if day % 7 == 5 || day % 7 == 0
			rng = CsRandom.new(game_id + day)
			(1..10).each do |i|
				index2 = rng.next(2, 790)
				loop do
					loop do
						index2 = (index2 + 1) % 790
						break if !(off_limits_for_sale.include? index2) && (Item.find_by item_key: index2)
					end
					str_array = Item.find_by(item_key: index2).information.split('/')
					break unless !(str_array[3].include? "-") || (str_array[1].to_i <= 0) || (str_array[3].include? "-13") || (str_array[3] == "Quest") || (str_array[0] == "Weeds") || (str_array[3].include? "Minerals") || (str_array[3].include? "Arch")
				end
				stock << index2
				#Implement price later. RNG still required to run to find next item value.
				rng.next
				rng.next
				rng.next_double
			end
		end
		stock
	end

	def format_items(item_keys)
		names = []
		item_keys.each do |item_key|
			str_array = Item.find_by(item_key: item_key).information.split('/')
			names << str_array[0]
		end
		names
	end

	def off_limits_for_sale
    [680, 681, 682, 688, 689, 690, 774, 775, 454, 460, 645, 413, 437, 439, 158, 159, 160, 161, 162, 163, 326, 341]
  end
end