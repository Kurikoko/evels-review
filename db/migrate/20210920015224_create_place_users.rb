class CreatePlaceUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :place_users do |t|

      t.timestamps

      t.references :user,  foreign_key: true, null: false
      t.references :place, foreign_key: true, null: false
    end
  end
end
