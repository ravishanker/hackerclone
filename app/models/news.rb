class News < ActiveRecord::Base

  attr_accessible :text, :title, :url, :votes_count
  validates :url,  :uniqueness => :true

  belongs_to :user
  has_many :votes, :as => :votable
  has_many :comments, :as => :commentable

  before_create :add_http_to_url

  def add_http_to_url
  	u = URI.parse(self.url)
  	unless u.scheme
  		self.url = 'http://' + self.url
  	end
  end

end
