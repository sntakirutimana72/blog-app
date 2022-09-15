class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'
  after_create :increment_posts_counter

  def increment_posts_counter
    author.with_lock do
      state = author.posts_counter || 0
      author.posts_counter = state + 1
      author.save
    end
  end

  def recent_five_comments
    comments.order(created_at: :desc).first(5)
  end
end
