class ScheduledMonthsController < ApplicationController

	# PSEUDO CODE
	#   if scheduled_month does not exist
	#     create it and create it's days
	#   else
	#     get_display_month



	def get_month
		month_num       = params[:month_num].to_i || Date.today.month
		scheduled_month = ScheduledMonth.where(month: month_num, year: session[:year])[0]

		if scheduled_month == nil
			ScheduledMonth.create_month_and_days(month_num, session[:year])
			scheduled_month = ScheduledMonth.where(month: month_num, year: session[:year])[0]			
		end

		calendar_month_user_array = scheduled_month.get_display_month(month_num,session[:year])
		session[:month_num]       = month_num

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

	def get_month_num
		session[:month_num] = Date.today.month unless session[:month_num]
		render json: {month_num: session[:month_num]}
	end


	






end
