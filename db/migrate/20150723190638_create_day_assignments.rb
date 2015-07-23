class CreateDayAssignments < ActiveRecord::Migration
  def change
    create_table :day_assignments do |t|
    	t.references   :user
    	t.date         :date

      t.timestamps null: false
    end
  end
end
