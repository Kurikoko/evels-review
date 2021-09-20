class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|

      t.timestamps
      t.string  :place_name,     null: false
      t.integer :area_id,        null: false
      t.string :carrier,         null:false
      t.integer :line_kinds_id,  null: false
      t.integer :fee_id,         null: false
      t.integer :backup_line_id, null: false
      t.integer :wifi_id,        null: false
    end
  end
end
