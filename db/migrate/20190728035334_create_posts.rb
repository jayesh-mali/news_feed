class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :created_by, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
