class DayAssignment < ActiveRecord::Base
	belongs_to  :user

	validates  :user_id, :date, presence: true
	validates  :date, uniqueness: true

	validate :cannot_be_weekend
	validate :check_if_california_holiday
	validate :cannot_be_on_no_can_do_day
	validate :duplicate_request, on: :update 
	validate :cannot_request_multiple_swaps_for_same_date, on: :update





	# CUSTOM VALIDATIONS

	def duplicate_request

		if self.swap_request_was != nil && self.swap_request != nil
			errors.add(:duplicate_request, "This day has already been requested")
		end

	end


	#         January 1, 2015  												January 5, 2015
	# { date: '1-1-2015', user: @user, swap_request: '1-5-2015', has_requested_swap: false }


	# day1
		# date:                8-5-2015
		# swap_request:        nil
		# has_requested_swap:  true
		
	# day2
		# date:                8-12-2015
		# swap_request:        8-5-2015
		# has_requested_swap:  false

	def cannot_request_multiple_swaps_for_same_date
		if self.swap_request
			date_requesting_to_swap = self.swap_request
			day_requesting = DayAssignment.where(date: date_requesting_to_swap)[0]
			if day_requesting.has_requested_swap_was != false 
				errors.add(:cannot_request_same_day, "You have already asked to swap this day.  You must wait until they confirm or deny your request.")
			end
		end

		# has requested swap
	end



	def cannot_be_weekend
		return if !self.date
		day = self.date.strftime("%A")
		if day == "Saturday" || day == "Sunday" 
			errors.add(:weekend_error, "can't schedule days on the weekend")
		end

	end

	def check_if_california_holiday
		# "month/day"
		return if !self.date
		holidays = ["01/01", "01/19", "02/16", "03/31", "05/25", "07/04", "09/07", "11/11", "11/26", "11/27", "12/25"]
		month_and_day = self.date.strftime("%m/%d")
		
		if holidays.include?(month_and_day)
			errors.add(:holiday_error, "can't schedule days on California holidays")				
		end

  end


  def cannot_be_on_no_can_do_day
  	if self.user
	  	no_can_do_day = self.user.no_can_do_day
	  	if self.date == no_can_do_day
	  		errors.add(:no_can_do_day_error, "can't schedule user on a day they specified as a no can do day")
	  	end
	  end
  end
  
  

end

