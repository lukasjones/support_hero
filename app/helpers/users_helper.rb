module UsersHelper

	def get_header_phrase
		day = DateTime.now.to_date.strftime("%A")
		if day === "Saturday" || day === "Sunday"
			"It's the weekend. No support for you today!"
		else
			user = DayAssignment.where(date: DateTime.now.to_date)[0].user
			"Today's Support Hero is #{user.name}"
		end
	end

	












end
