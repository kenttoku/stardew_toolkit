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

		# Cart only shows up on Fridays and Sundays
		if day % 7 == 5 || day % 7 == 0
			rng = CsRandom.new(game_id + day)
			# 10 Normal Item Slots
			(1..10).each do |i|
				item_info = []
				item_key = rng.next(2, 790)
				loop do
					loop do
						item_key = (item_key + 1) % 790
						break if !(off_limits_for_sale.include? item_key) && (Item.find_by item_key: item_key)
					end
					str_array = Item.find_by(item_key: item_key).information.split('/')
					break unless !(str_array[3].include? "-") || (str_array[1].to_i <= 0) || (str_array[3].include? "-13") || (str_array[3] == "Quest") || (str_array[0] == "Weeds") || (str_array[3].include? "Minerals") || (str_array[3].include? "Arch")
				end
				str_array = Item.find_by(item_key: item_key).information.split('/')
				item_info << get_item_name(item_key) #Item Name
				item_info << [rng.next(1, 11) * 100, str_array[1].to_i * rng.next(3, 6)].max #Item Price
				item_info << (rng.next_double < 0.1 ? 5 : 1) # Item Stock
				stock << item_info
			end

			# One Random Furniture
			furniture_info = []
			furniture_key = 0
			loop do
				furniture_key = rng.next(0, 1613)
				break if !(furniture_off_limits_for_sale.include? furniture_key) && (Furniture.find_by furniture_key: furniture_key)
			end
			str_array = Furniture.find_by(furniture_key: furniture_key).information.split('/')
			furniture_info << str_array[0]
			furniture_info << rng.next(1,11) * 250
			furniture_info << 1
			stock << furniture_info

			# Rare Seeds appear in the Spring/Summer
			if season(day) == "Spring" || season(day) == "Summer"
				item_info = ["Rare Seed", 1000, (rng.next_double < 0.1 ? 5 : 1)]
				stock << item_info
			# Rarecrow has a 40% Chance of appearing in the Fall/Winter
			elsif rng.next_double < 0.4
				item_info = ["Rarecrow (4 of 8)", 4000, 1]			
				stock << item_info
			end

			# Coffee Beans have a 25% Chance of appearing all year
			if rng.next_double < 0.25
				item_info = ["Cofee Bean", 2500, 1]
				stock << item_info
			end
		end
		stock
	end

	def get_item_name(item_key)
		str_array = Item.find_by(item_key: item_key).information.split('/')
		str_array[0]
	end


	def off_limits_for_sale
    [680, 681, 682, 688, 689, 690, 774, 775, 454, 460, 645, 413, 437, 439, 158, 159, 160, 161, 162, 163, 326, 341]
  end

  def furniture_off_limits_for_sale
  	[1680, 1733, 1669, 1671, 1541, 1545, 1554, 1402, 1466, 1468, 131, 1226, 1298, 1299, 1300, 1301, 1302, 1303, 1304, 1305, 1306, 1307, 1308]
  end
end