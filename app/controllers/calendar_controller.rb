class CalendarController < ApplicationController


	def change_month
		p params[:num]
		
		render partial: 'calendar', locals: {month: params[:num].to_i, year: 2015}
	end

	

end
