class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :increment_comments_counter

  validates :text, presence: true

  def increment_comments_counter
    post.with_lock do
      state = post.comments_counter || 0
      post.comments_counter = state + 1
      post.save
    end
  end
end
