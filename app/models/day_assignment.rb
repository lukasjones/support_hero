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
		# "month/day"
		holidays = ["01/01", "01/19", "02/16", "03/31", "05/25", "07/04", "09/07", "11/11", "11/26", "11/27", "12/25"]
		month_and_day = self.date.strftime("%m/%d")
		
		if holidays.include?(month_and_day)
			errors.add(:holiday_error, "can't schedule days on California holidays")				
		end

  end

  def swap_user(first_date, second_date)
		first_user = get_user_from_date(first_date)
		second_user = get_user_from_date(second_date)
		DayAssignment.where(date: first_date).update_attributes(user: first_user)
		DayAssignment.where(date: second_date).update_attributes(user: second_user)
	end

	private



	def get_user_from_date(date)
		DayAssignment.where(date: date)[0].user
	end
end

