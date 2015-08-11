class ScheduledMonth < ActiveRecord::Base
	has_many :days

	validates_uniqueness_of :month, :scope => :year




	# model mehtods

	def get_display_month(month, year)
		calendar_month_user_array = ScheduledMonth.where(month: month, year: year)[0].days.order(:date)
		calendar_month_user_array = get_last_week_of_prev_month + calendar_month_user_array
		calendar_month_user_array = calendar_month_user_array + get_first_week_of_next_month
		calendar_month_user_array
	end

	def prev_month
		date = "1-#{self.month}-#{self.year}".to_date - 1.month
		ScheduledMonth.where(month: date.month, year: date.year)[0]
	end

	def next_month
		date = "1-#{self.month}-#{self.year}".to_date + 1.month
		ScheduledMonth.where(month: date.month, year: date.year)[0]
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
