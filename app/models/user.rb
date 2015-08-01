class User < ActiveRecord::Base

	has_many :day_assignments

	before_update :ensure_not_in_same_month


	def ensure_not_in_same_month
		p self.no_can_do_day
	end

	
	

end
