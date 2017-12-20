class CalendarsController < ApplicationController
	def up_year
		calendar = Calendar.first
		calendar.day += 112
		calendar.save!
		redirect_to tools_mines_path
	end

	def down_year
		calendar = Calendar.first
		calendar.day -= 112
		calendar.save!
		redirect_to tools_mines_path
	end

	def up_season
		calendar = Calendar.first
		calendar.day += 28
		calendar.save!
		redirect_to tools_mines_path
	end

	def down_season
		calendar = Calendar.first
		calendar.day -= 28
		calendar.save!
		redirect_to tools_mines_path
	end
end
