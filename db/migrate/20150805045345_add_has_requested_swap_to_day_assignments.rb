class AddHasRequestedSwapToDayAssignments < ActiveRecord::Migration
  def change
  	add_column :day_assignments, :has_requested_swap, :boolean, default: false
  end
end
