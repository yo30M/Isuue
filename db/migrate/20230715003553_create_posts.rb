class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :address, null: false
      t.text :comfort, null: false
      t.text :environment, null: false


      t.timestamps
    end
  end
end
