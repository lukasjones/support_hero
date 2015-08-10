class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|

      t.references :scheduled_month
      t.references :user, default: nil

      t.date       :date
      t.date       :swap_request

      t.boolean    :has_requested_swap, default: false

      t.integer    :day_of_month_num

      t.string     :week_day_name
      t.string     :user_name, default: nil

      t.timestamps null: false
    end
  end
end

