class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :details, null: false
      t.boolean :private, default: false
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
