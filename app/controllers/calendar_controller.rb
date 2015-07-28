class CalendarController < ApplicationController


	def change_month
		# set the current year in a session if not already set 
		session[:year] = DateTime.now.to_date.year unless session[:year]

		num = params[:num].to_i
		if num === 13
			num = 1
			session[:year] += 1
		elsif num === 0
			num = 12
			session[:year] -= 1
		end
		
		render partial: 'calendar', locals: {month: num, year: session[:year]}
	end


	

end


