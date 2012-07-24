class News < ActiveRecord::Base
  belongs_to :user
  attr_accessible :text, :title, :url, :votes_count
  validates :url,  :uniqueness => :true

end
