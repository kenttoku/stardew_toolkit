class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :item_key
      t.string :information

      t.timestamps
    end
  end
end
