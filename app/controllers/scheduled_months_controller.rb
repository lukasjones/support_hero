class ScheduledMonthsController < ApplicationController

	def get_month
		month_num                 = params[:month_num].to_i
		scheduled_month           = ScheduledMonth.where(month: month_num, year: session[:year])[0]
		session[:month_num]       = month_num
		calendar_month_user_array = scheduled_month.get_display_month(month_num,session[:year])

		render partial: 'shared/calendar', locals: {month: month_num, year: session[:year], calendar_month_user_array: calendar_month_user_array}
	end


	def get_next_month
		next_scheduled_month = ScheduledMonth.where(month: session[:month_num], year: session[:year])[0].next_month
		session[:year]       = next_scheduled_month.year

		redirect_to "/get_month/#{next_scheduled_month.month}"
	end

	def get_prev_month
		prev_scheduled_month = ScheduledMonth.where(month: session[:month_num], year: session[:year])[0].prev_month
		session[:year]       = prev_scheduled_month.year

		redirect_to "/get_month/#{prev_scheduled_month.month}"
	end








end
