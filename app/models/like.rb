class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :increment_likes_counter

  def increment_likes_counter
    post.with_lock do
      state = post.likes_counter || 0
      post.likes_counter = state + 1
      post.save
    end
  end
end
