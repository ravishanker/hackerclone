class News < ActiveRecord::Base

  attr_accessible :text, :title, :url, :votes_count
  validates :url,  :uniqueness => :true

  belongs_to :user
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable

end
