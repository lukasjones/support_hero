module DayAssignmentsHelper

	def user_from_date(date)
		DayAssignment.where(date: date)[0].user
	end

	def assigned_day_from_date(date)
		DayAssignment.where(date: date)[0]
	end

end
