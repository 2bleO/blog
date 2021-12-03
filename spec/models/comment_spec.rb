require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe Comment, type: :model do
  describe '#update_counter' do
    DatabaseCleaner.clean
    random = Random.new
    User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
                  confirmed_at: Date.today)
    User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2',
                  bio: 'Hello Im User2.', confirmed_at: Date.today)
    post = Post.create(title: "Post #1", text: "This is post 1", author: User.second)
    subject do
      Comment.create(text: 'Comment #1', post: post, author: User.first)
    end
    
    it 'should update the post comments counter' do
      expect(subject.post.comments_counter).to be(1)
    end
  end
end
