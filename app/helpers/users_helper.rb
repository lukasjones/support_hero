module UsersHelper

	def get_header_phrase(date)
		day = date.strftime("%A")
		if day === "Saturday" || day === "Sunday"
			"It's the weekend. No support today!"

		elsif ["01/01", "01/19", "02/16", "03/31", "05/25", "07/04", "09/07", "11/11", "11/26", "11/27", "12/25"].include?(date.strftime("%m/%d"))
			"It's a holiday! Go celebrate!"
		else
			user = DayAssignment.where(date: date)[0].user
			"Today's Support Hero is #{user.name}"
		end
	end

	

end
