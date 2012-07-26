class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content

  belongs_to :commentable, :polymorphic => true

  belongs_to :user
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable


end
