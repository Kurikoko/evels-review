class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|

      t.timestamps
      t.string  :place_name, null: false
      t.integer :area_id,    null: false
    end
  end
end
