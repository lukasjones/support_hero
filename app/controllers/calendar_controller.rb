class CalendarController < ApplicationController


	def change_month
		num = params[:num].to_i
		if num === 13
			num = 1
			session[:year] += 1
		elsif num === 0
			num = 12
			session[:year] -= 1
		end
		
		render partial: 'shared/calendar', locals: {month: num, year: session[:year]}
	end


	

end


