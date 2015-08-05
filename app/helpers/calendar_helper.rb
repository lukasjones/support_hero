module CalendarHelper

	
	def month_integer_to_string(num)
		month_hash = {1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December"}
		month_hash[num]
	end


	def pretty_date(date)
		"#{Date::MONTHNAMES[date.month]} #{date.day}, #{date.year}"
	end



end


