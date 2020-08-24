class CreateHabits < ActiveRecord::Migration[6.0]
  def change
    create_table :habits do |t|
      t.text :name
      t.text :description
      t.integer :goal_id
      t.boolean :complete

      t.timestamps
    end
  end
end
