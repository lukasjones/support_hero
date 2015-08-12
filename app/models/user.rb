class User < ActiveRecord::Base


	validates :name, presence: true

	has_many :days

	validate :wait_one_month_to_get_new_undoable_day

	after_commit :reschedule, on: :update

	

	def wait_one_month_to_get_new_undoable_day
		if self.no_can_do_day_was == nil
			true
		elsif self.no_can_do_day != nil && self.updated_at.month == Date.today.month
			errors.add(:wait_a_month, "You need to wait until next month to mark another day as undoable")
		end
	end


  protected

	def reschedule
		sorted_scheduled_user_count_arr = get_sorted_amount_scheduled_for_each_user
		unschedule_day(self.no_can_do_day)
		sorted_scheduled_user_count_arr.each do |name, number|
			user = User.where(name: name)[0]
			day = Day.where(date: self.no_can_do_day)[0]
			day.update_attributes(user: user)
			if day.valid?
				day.save
				break
			else
				next
			end
		end
	end


	def get_sorted_amount_scheduled_for_each_user
		users_day_count_hash = Hash.new
		User.all.each do |user|
			users_day_count_hash[user.name] = user.days.length
		end
		users_day_count_hash.sort_by{ |k,v| v }
	end


	def unschedule_day(date)
		Day.where(date: date)[0].update_attributes(user: nil);
	end



	
	

end
