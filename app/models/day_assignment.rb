class DayAssignment < ActiveRecord::Base
	belongs_to  :user

	validates  :user_id, :date, presence: true
	validates  :date, uniqueness: true
end
