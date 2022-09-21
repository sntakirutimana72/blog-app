module PostsHelper
  def has_comments(post)
    !(post.comments_counter.nil? || post.comments_counter.zero?)
  end
end
