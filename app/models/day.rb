class Day < ActiveRecord::Base

	belongs_to :scheduled_month
	belongs_to :user

	before_save :set_user_fields
	before_save :set_date_fields
	
	validates  :date, presence: true, uniqueness: true

	validate :cannot_be_weekend
	validate :cannot_be_california_holiday
	validate :cannot_be_on_no_can_do_day
	validate :duplicate_request, on: :update 
	validate :cannot_request_multiple_swaps_for_same_date, on: :update



	# before save

	def set_user_fields
		if !user
			self.user_name = nil
			self.user_id   = nil
			self.has_requested_swap = false
		else
			self.user_name = user.name
			self.user_id   = user.id
		end
		true
	end

	def set_date_fields
		self.week_day_name    = self.date.strftime("%A")
		self.day_of_month_num = self.date.day
		if ScheduledMonth.where(month: date.month, year: date.year).empty?
			self.scheduled_month  = ScheduledMonth.create(month: date.month, year: date.year)
		else
			self.scheduled_month  = ScheduledMonth.where(month: date.month, year: date.year)[0]
		end
		true
	end




	# CUSTOM VALIDATIONS

	def duplicate_request
		return if !user
		if self.swap_request_was != nil && self.swap_request != nil
			errors.add(:duplicate_request, "This day has already been requested")
		end
	end

	def cannot_request_multiple_swaps_for_same_date
		return if !user
		if self.swap_request
			date_requesting_to_swap = self.swap_request
			day_requesting = Day.where(date: date_requesting_to_swap)[0]
			if day_requesting.has_requested_swap_was != false 
				errors.add(:cannot_request_same_day, "You have already asked to swap this day. ")
			end
		end

	end

	def cannot_be_weekend
		return if !user
		return if !self.date
		day = self.date.strftime("%A")
		if day == "Saturday" || day == "Sunday" 
			errors.add(:weekend_error, "can't schedule days on the weekend")
		end

	end

	def cannot_be_california_holiday
		# "month/day"
		return if !user
		return if !self.date
		holidays = ["01/01", "01/19", "02/16", "03/31", "05/25", "07/04", "09/07", "11/11", "11/26", "11/27", "12/25"]
		month_and_day = self.date.strftime("%m/%d")
		
		if holidays.include?(month_and_day)
			errors.add(:holiday_error, "can't schedule days on California holidays")				
		end

  end


  def cannot_be_on_no_can_do_day
  	return if !user
  	if self.user
	  	no_can_do_day = self.user.no_can_do_day
	  	if self.date == no_can_do_day
	  		errors.add(:no_can_do_day_error, "can't schedule user on a day they specified as a no can do day")
	  	end
	  end
  end
  

end
