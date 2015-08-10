class Day < ActiveRecord::Base

	
	
end

# class Day
# 	include ActiveModel::Model

# 	attr_reader :date, :week_day_name, :num, :scheduled_user_name, :scheduled_user_id

# 	attr_accessor :scheduled_user


# 	def initialize(attributes={})
# 		@date                = attributes[:date] || nil
# 		@scheduled_user      = attributes[:user] || nil 
# 		@scheduled_user_name = @scheduled_user ? @scheduled_user.name : nil
# 		@scheduled_user_id   = @scheduled_user ? @scheduled_user.id : nil
# 		@week_day_name       = @date ? @date.strftime("%A") : nil
# 		@num                 = @date ? @date.day : nil
# 	end

# 	def update_user(user)
# 		@scheduled_user      = user
# 		@scheduled_user_name = user.name
# 		@scheduled_user_id   = user.id
# 	end

	

# end
