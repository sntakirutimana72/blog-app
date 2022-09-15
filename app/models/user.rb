class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  def recent_three_posts
    posts.order(created_at: :desc).first(3)
  end
end
