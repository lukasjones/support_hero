module UsersHelper

	def current_month
		current_month_array = []
		month = DateTime.now.month
		year = DateTime.now.year
		current_day = "1-#{month}-#{year}".to_date

		until current_day.month != month do
			current_month_array.push(current_day)
			current_day = current_day.tomorrow.to_date
		end

		current_month_array
	end

	def get_calendar_month(month, year)

		month_array = []
		
		current_day = "1-#{month}-#{year}".to_date
		until current_day.month != month do
			month_array.push(current_day)
			current_day = current_day.tomorrow.to_date
		end

		put_days_in_order(month_array)



	end



	def put_days_in_order(month_array)

		spaces = 0
		days_of_the_week_hash = {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6 }
		if month_array[0].strftime("%A") != "Sunday"
			spaces = days_of_the_week_hash[month_array[0].strftime("%A")]
		end

		month_array.map! {|day| day.day }

		spaces.times do
			month_array.unshift("")
		end

		month_array



	end















end
