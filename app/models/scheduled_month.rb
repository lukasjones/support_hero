class ScheduledMonth < ActiveRecord::Base
	has_many :days

	validates_uniqueness_of :month, :scope => :year
end
