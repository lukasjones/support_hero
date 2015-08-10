class CreateScheduledMonths < ActiveRecord::Migration
  def change
    create_table :scheduled_months do |t|

    	t.integer    :month
    	t.integer    :year

      t.timestamps null: false
    end
  end
end
