class AddDefaultValueToGoals < ActiveRecord::Migration[6.0]
  def change
    change_column :goals, :complete, :boolean, default: false
  end
end
