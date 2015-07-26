class DayAssignment < ActiveRecord::Base
	belongs_to  :user

	validates  :user_id, :date, presence: true
	validates  :date, uniqueness: true

	validate :cannot_be_weekend
	validate :check_if_california_holiday


	def cannot_be_weekend
		day = self.date.strftime("%A")
		if day == "Saturday" || day == "Sunday" 
			errors.add(:weekend_error, "can't schedule days on the weekend")
		end
	end

	def check_if_california_holiday
		holidays = ["01/01", "01/19", "02/16", "03/31", "05/25", "07/04 ", "09/07 ", "11/11", "11/26", "11/27", "12/25"]
		month_and_day = self.date.strftime("%m/%d")
		any_errors = false
		holidays.each do |holiday|
			if month_and_day == holiday
				any_errors = true
			end
		end

		if any_errors
			errors.add(:holiday_error, "can't schedule days on California holidays")				
		end

  end
end

