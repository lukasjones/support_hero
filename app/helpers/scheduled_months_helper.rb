module ScheduledMonthsHelper

	def month_integer_to_string(num)
		month_hash = {1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December"}
		month_hash[num]
	end


	def pretty_date(date)
		"#{Date::MONTHNAMES[date.month]} #{date.day}, #{date.year}"
	end

	def ugly_date(current_day)
		"#{current_day.day_of_month_num}-#{session[:month_num]}-#{session[:year]}"
	end

	def set_selected(current_day)
		if session[:selected_user] == current_day.user_name
			'class=selected' 
		elsif current_day.date.month != session[:month_num]
			'class=faded'
		end
	end
	
end
