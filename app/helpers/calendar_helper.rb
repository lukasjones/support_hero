module CalendarHelper

	def get_calendar_month(month, year)
		# set the current year in a session if not already set 
		session[:year] = DateTime.now.to_date.year - 1 unless session[:year]


		month_array = []
		
		current_day = "1-#{month}-#{year}".to_date
		until current_day.month != month do
			month_array.push(current_day)
			current_day = current_day.tomorrow.to_date
		end

		put_days_in_order(month_array)



	end



	def put_days_in_order(month_array)

		days_of_the_week_hash = {"Sunday" => 0, "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6 }
			beginning_spaces = days_of_the_week_hash[month_array[0].strftime("%A")]

			trailing_spaces = 7 - (days_of_the_week_hash[month_array[-1].strftime("%A")] + 1)


		month_array.map! do |day|
			if DayAssignment.where(date: day)[0]
				blah = DayAssignment.where(date: day)[0].user
				[day.day, blah.id, blah.name]
			else
				[day.day, "", ""]
			end

		end

		# month_array.map! {|day| day.day }

		beginning_spaces.times do
			month_array.unshift("")
		end

		trailing_spaces.times do 
			month_array.push("")
		end


		month_array



	end

	def month_integer_to_string(num)
		month_hash = {1 => "January", 2 => "February", 3 => "March", 4 => "April", 5 => "May", 6 => "June", 7 => "July", 8 => "August", 9 => "September", 10 => "October", 11 => "November", 12 => "December"}
		month_hash[num]
	end



end


