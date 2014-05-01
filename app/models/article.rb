class Article < ActiveRecord::Base
  attr_accessible :content, :imageurl
  belongs_to :user
  validates :username, presence: true
  validates :content,  presence: true, length: { minimum: 100 }

  default_scope order: 'articles.created_at DESC'
end
