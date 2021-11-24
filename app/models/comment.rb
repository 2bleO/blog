class Comment < ApplicationRecord
  belongs_to :user
  has_many :posts

  def update_comments_counter
    post.update(comments_counter: Comment.where(post_id: post).count)
  end
end
