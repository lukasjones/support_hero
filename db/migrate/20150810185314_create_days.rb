class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|

    	t.date       :date
    	t.references :user, default: nil
    	t.string     :user_name, default: nil
    	t.integer    :user_id, default: nil
    	t.string     :week_day_name
    	t.integer    :day_of_month_num
      t.references :scheduled_month

      t.timestamps null: false
    end
  end
end

