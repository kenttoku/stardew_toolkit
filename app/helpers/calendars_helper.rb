module CalendarsHelper
	def year(day)
		1 + day / 112
	end

	def season(day)
		case day % 112
		when 1..28
			"Spring"
		when 29..56
			"Summer"
		when 57..84
			"Fall"
		else
			"Winter"
		end
	end
end
