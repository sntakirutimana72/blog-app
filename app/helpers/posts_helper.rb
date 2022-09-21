module PostsHelper
  def comments?(post)
    !(post.comments_counter.nil? || post.comments_counter.zero?)
  end
end
