# Support Hero  

## Description

This is a scheduling application that stores and displays the on-duty days for a team.  Every day, one person is given the duty of Support Hero.  

The index page shows the name of support hero of the day and a calendar month with the users that are assigned to each day.  

The users may mark one day a month as undoable.  If they do this, the user that has been assigned the least number of days (that hasn't marked the day as undoable) so far will be scheduled to work that day.

Users may also choose to swap days.  This process has two steps:  
(from the user's profile page)

1. The user asks another user to swap a day
2. The user being asked can then accept or deny the request.

Limits:

* The user cannot ask to swap the same day with multiple people. for example: if I asked to swap January 1st, 2015 with Mark and (before mark could confirm or deny my request) I asked to swap January 1st, 2015 with Amy, the system would give the user an error telling them it's not possible.
* The user will be given an error if they ask to swap a day that someone else has asked (but not been answered).


## Assumptions

* You are running the app in California. The apps scheduling takes into account California holidays.
* You do not want to schedule users on the weekends.
* Only one person is scheduled per day.
* You must wait for someone to accept or deny a swap request before you can ask for another on the same date.


## Getting Started

(assuming you have Ruby > 2.0.0 , Git and Rails > 4.0.0 installed)

1. git clone https://github.com/lukasjones/support_hero.git
2. cd support_hero
3. bundle install
4. rake db:create db:migrate 
5. rake db:seed **before running rake db:seed go into the seed file and change the starting order to the names you want(first names only)**.
6. rails s

open up your browser of choice and type http://localhost:3000/


## Class Design


ScheduledMonth
- has_many days

Day
- Uses the DayAssignments instances to assign users to days.
- Can also be blank and not break the view.
- Day assignment belong to a user.


User
- Users have many day assignments.
 

![Schema](./mockup_and_schema/support_hero_schema.png)






Features:
* Display today's Support Hero
* Display single user's schedule 
* Display full schedule for Support Heros
* Users can mark one day as undoable
  * System should reschedule
  * Take into account weekends and holidays
* Users should be able to swap days




- Requirements for service (what does the service do)
- Limitations and Assumptions (Is only valid for California)
- Design (How is the class laid out, flow between classes, can use class and sequence diagrams)
- How to deploy the software as a service
- How to use