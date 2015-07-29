class AddNoCanDoDayToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :no_can_do_day, :date
  end
end



