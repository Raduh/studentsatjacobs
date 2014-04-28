class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.string :imageurl
      t.string :username

      t.timestamps
    end
    add_index :articles, [:username,:created_at]
  end
end
