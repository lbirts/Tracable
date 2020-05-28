class AddDefaultValueToHabits < ActiveRecord::Migration[6.0]
  def change
    change_column :habits, :complete, :boolean, default: false
  end
end
