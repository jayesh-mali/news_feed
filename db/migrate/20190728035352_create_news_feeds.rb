class CreateNewsFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :news_feeds do |t|
      t.references :postable, polymorphic: true, index: true
      t.references :created_by, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
