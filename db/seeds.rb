# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


starting_line_up = ["Sherry", "Boris", "Vicente", "Matte", "Jack", "Sherry",
 "Matte", "Kevin", "Kevin", "Vicente", "Zoe", "Kevin",
 "Matte", "Zoe", "Jay", "Boris", "Eadon", "Sherry",
 "Franky", "Sherry", "Matte", "Franky", "Franky", "Kevin",
 "Boris", "Franky", "Vicente", "Luis", "Eadon", "Boris",
 "Kevin", "Matte", "Jay", "James", "Kevin", "Sherry",
 "Sherry", "Jack", "Sherry", "Jack"]

starting_users = starting_line_up.uniq

# Creating Users

starting_users.each do |name|
 	User.create(name: name)
end

# creating scheduled months
date = DateTime.now - 12.month
50.times do 
	ScheduledMonth.create(month: date.month, year: date.year)
	date += 1.month
end

# Create Days
ScheduledMonth.all.each do |month|

	current_date  = "1-#{month.month}-#{month.year}".to_date
	until current_date.month != month.month
		# byebug
		Day.create(date: current_date)
		current_date = current_date.tomorrow
	end
end

# Creating Day Assignments
date = Date.today
starting_line_up.each do |name|
	user = User.where(name: name)[0]

	assignment = Day.where(date: date)[0]
	assignment.update_attributes(user: user)
	if assignment.valid?
		assignment.save
		date = date.tomorrow
	else
		while !assignment.valid?
			date = date.tomorrow
			assignment = Day.where(date: date)[0]
			assignment.update_attributes(user: user)
		end
		assignment.save
	end
end









