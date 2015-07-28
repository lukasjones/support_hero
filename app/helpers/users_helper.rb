module UsersHelper

	# def current_month
	# 	current_month_array = []
	# 	month = DateTime.now.month
	# 	year = DateTime.now.year
	# 	current_day = "1-#{month}-#{year}".to_date

	# 	until current_day.month != month do
	# 		current_month_array.push(current_day)
	# 		current_day = current_day.tomorrow.to_date
	# 	end

	# 	current_month_array
	# end

	def get_header_phrase
		day = DateTime.now.to_date.strftime("%A")
		if day === "Saturday" || day === "Sunday"
			"It's the weekend. No support for you today!"
		else
			user = DayAssignment.where(date: DateTime.now.to_date)[0].user
			"Today's Support Hero is #{user.name}"
		end
	end

	












end
