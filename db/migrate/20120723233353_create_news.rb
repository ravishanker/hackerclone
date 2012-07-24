class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :text
      t.references :user
      t.integer :votes_count

      t.timestamps
    end
    add_index :news, :user_id
    add_index :news, :url
  end
end
