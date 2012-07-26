class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote
      # t.integer :votable_id
      # t.string :votable_type
      t.references :votable, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end
end
