class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :category_id
      t.string :description
      t.date :due_date
      t.integer :cheers
      t.integer :user_id

      t.timestamps
    end
  end
end 
