class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  after_create :increment_posts_counter

  validates :title, presence: true, length: { in: 1..250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
