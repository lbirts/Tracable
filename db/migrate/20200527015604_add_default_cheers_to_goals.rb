class AddDefaultCheersToGoals < ActiveRecord::Migration[6.0]
  def change
    change_column :goals, :cheers, :integer, default: 0
  end
end