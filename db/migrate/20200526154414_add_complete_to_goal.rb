class AddCompleteToGoal < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :complete, :boolean
  end
end
