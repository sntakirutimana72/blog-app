class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  after_create :increment_comments_counter

  validates :text, presence: true

  def increment_comments_counter
    post.increment!(:comments_counter)
  end
end
