class ScheduledMonth < ActiveRecord::Base
	has_many :days

	validates_uniqueness_of :month, :scope => :year


	# model methods

	def get_display_month(month, year)
		calendar_month_user_array = ScheduledMonth.where(month: month, year: year)[0].days.order(:date)
		calendar_month_user_array = get_last_week_of_prev_month + calendar_month_user_array
		calendar_month_user_array = calendar_month_user_array + get_first_week_of_next_month
		calendar_month_user_array
	end

	def prev_month
		date = "1-#{self.month}-#{self.year}".to_date - 1.month
		month = date.month
		year = date.year
		scheduled_month = ScheduledMonth.where(month: month, year: year)[0]
		if scheduled_month == nil
			ScheduledMonth.create_month_and_days(month, year)
			scheduled_month = ScheduledMonth.where(month: month, year: year)[0]
		end

		scheduled_month
	end

	def next_month
		date = "1-#{self.month}-#{self.year}".to_date + 1.month
		month = date.month
		year = date.year
		scheduled_month = ScheduledMonth.where(month: month, year: year)[0]
		if scheduled_month == nil
			ScheduledMonth.create_month_and_days(month, year)
			scheduled_month = ScheduledMonth.where(month: month, year: year)[0]
		end

		scheduled_month
	end
	
	def self.create_month_and_days(month, year)
		today = Date.today
		month = today.month unless month != nil
		year  = today.year unless year != nil

		scheduled_month = ScheduledMonth.create(month: month, year: year)
		current_date = "1-#{month}-#{year}".to_date
		until current_date.month != month
			if !Day.where(date: current_date)[0]
				Day.create(date: current_date)
			end
			current_date = current_date.tomorrow
		end

	end

	private

	def get_last_week_of_prev_month
		
		last_week = prev_month.days.order(:date).last(7)
		output = []
		last_week.reverse.each do |day|
			break if day.week_day_name === "Saturday"
			output.unshift(day)
		end
		output
	end

	def get_first_week_of_next_month
		first_week = next_month.days.order(:date).first(7)
		output = []
		first_week.each do |day|
			break if day.week_day_name === "Sunday"
			output.push(day)
		end
		output
	end


end
