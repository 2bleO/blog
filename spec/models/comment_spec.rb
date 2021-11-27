require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_counter' do
    random = Random.new
    users = User.all
    posts = Post.all
    subject do
      Comment.create(text: 'Comment #1', post: posts[random.rand(posts.count)], author: users[random.rand(users.count)])
    end

    it 'should update the post comments counter' do
      expect(subject.post.comments_counter).to be(1)
    end
  end
end
