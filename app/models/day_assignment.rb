class DayAssignment < ActiveRecord::Base
	belongs_to  :user

	validates  :user_id, :date, presence: true
	validates  :date, uniqueness: true

	validate :cannot_be_weekend
	validate :check_if_california_holiday
	validate :cannot_be_on_no_can_do_day



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


  def cannot_be_on_no_can_do_day
  	no_can_do_day = self.user.no_can_do_day
  	if self.date == no_can_do_day
  		errors.add(:no_can_do_day_error, "can't schedule user on a day they specified as a no can do day")
  	end
  end

  


  
  

end

