class Vote < ActiveRecord::Base
  attr_accessible :votable_id, :votable_type, :vote

  belongs_to :votable, :polymorphic => true
  belongs_to :user
end
