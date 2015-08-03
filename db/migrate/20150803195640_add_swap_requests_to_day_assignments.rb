class AddSwapRequestsToDayAssignments < ActiveRecord::Migration
  def change
  	add_column :day_assignments, :swap_request, :integer
  end
end
