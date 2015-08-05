class CalendarSchedule
	include ActiveModel::Model

	attr_reader :year, :year_calendar

	def initialize(attributes={})
		@year                  = attributes[:year] || Date.today.year
		@starting_order        = attributes[:starting_order] || User.all.map {|user| user.name} * 5
		@year_calendar         = Array.new(12)
	end

	def get_month(month_num)
		# if @year_calendar[month_num-1]
		# 	month = @year_calendar[month_num-1].dup
		# 	add_empty_days_for_view(month)
		# else
		# end
		set_and_schedule_month(month_num)
		month = @year_calendar[month_num-1].dup
		add_empty_days_for_view(month)

	end



	private

	# maybe switch this to use starting order



	def set_and_schedule_month(month_num)
		set_month(month_num)
		schedule_month(month_num)
	end


	def set_month(month_num)
		month_days_array = []
		current_day = "1-#{month_num}-#{@year}".to_date
		until current_day.month != month_num do
			day = Day.new({date: current_day})
			month_days_array.push(day)
			current_day = current_day.tomorrow
		end
		@year_calendar[month_num-1] = month_days_array
	end



	def schedule_month(month_num)
		month = @year_calendar[month_num-1]
		month.each do |day|
			day_assigned = DayAssignment.where(date: day.date)[0]
			if day_assigned
				user = day_assigned.user
				day.update_user(user)
			end
		end
	end

	def add_empty_days_for_view(month_arr)
		days_of_the_week_hash = {"Sunday" => 0, "Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6 }
		beginning_spaces = days_of_the_week_hash[month_arr[0].date.strftime("%A")]
		trailing_spaces = 7 - (days_of_the_week_hash[month_arr[-1].date.strftime("%A")] + 1)

		beginning_spaces.times do
			month_arr.unshift(Day.new)
		end

		trailing_spaces.times do 
			month_arr.push(Day.new)
		end

		month_arr
	end






end






