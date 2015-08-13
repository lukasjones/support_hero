require 'rails_helper'

RSpec.describe ScheduledMonth, type: :model do

	it "should save a scheduled month with a unique month and year" do
		scheduled_month = ScheduledMonth.new(month: 1, year: 2000)
		expect(scheduled_month.save).to eq(true)
	end

	it "should not save a duplicate scheduled month" do
		ScheduledMonth.create(month: 8, year: 2014)
		scheduled_month = ScheduledMonth.new(month: 8, year: 2014)
		expect(scheduled_month.save).to eq(false)
	end
  
end
