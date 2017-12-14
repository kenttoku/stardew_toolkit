class CreateCsRandoms < ActiveRecord::Migration[5.1]
  def change
    create_table :cs_randoms do |t|

      t.timestamps
    end
  end
end
