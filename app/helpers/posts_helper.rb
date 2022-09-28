module PostsHelper
  def zero_comments?(post)
    post.comments_counter.nil? || post.comments_counter.zero?
  end

  def which_comments(post, all)
    all ? post.comments.includes(:author) : post.recent_five_comments
  end
end
