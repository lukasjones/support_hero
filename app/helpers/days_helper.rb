module DaysHelper

	def user_from_date(date)
		Day.where(date: date)[0].user
	end

	def assigned_day_from_date(date)
		Day.where(date: date)[0]
	end
	
end
