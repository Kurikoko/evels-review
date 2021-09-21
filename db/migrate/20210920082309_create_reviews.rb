class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|

      t.timestamps
      t.references :user,     foreign_key: true, null: false
      t.references :place,    foreign_key: true, null: false
      t.float      :download, null: false
      t.float      :upload,   null: false
      t.text       :comment,  null: false
    end
  end
end
