class AddNoCanDoDayToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :no_can_do_day, :date
  end
end

class AddDescriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :description, :string
  end
end

