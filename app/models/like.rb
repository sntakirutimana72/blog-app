class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :increment_likes_counter

  def increment_likes_counter
    post.increment!(:likes_counter)
  end
end
