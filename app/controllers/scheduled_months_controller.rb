class ScheduledMonthsController < ApplicationController

	def get_month
		month_num = params[:month_num].to_i
		calendar_month_user_array = ScheduledMonth.where(month: month_num, year: session[:year])[0].days
		render partial: 'shared/calendar', locals: {month: month_num, year: session[:year]}
	end










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
