class CreateFurnitures < ActiveRecord::Migration[5.1]
  def change
    create_table :furnitures do |t|
      t.integer :furniture_key
      t.string :information

      t.timestamps
    end
  end
end
