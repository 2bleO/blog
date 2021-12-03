require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    DatabaseCleaner.clean
    User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
                confirmed_at: Date.today)
    Post.create(title: 'Post title', text: 'This is a Test', author: User.first)
    before(:example) { get user_posts_path(1) }

    it 'should have correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end

    it 'should include correct placeholder text' do
      expect(response.body).to include('This is a Test')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_post_path(1, 1) }

    it 'should have correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:show)
    end

    it 'should include correct placeholder text' do
      expect(response.body).to include('This is a Test')
    end
  end

  describe 'last_comments method' do
    it 'Should return 5 recently added comments' do
      @user = User.first
      @post = Post.last

      10.times do |i|
        Comment.create(text: "comment ##{i}", author: @user, post: @post)
      end
      expect(@post.last_comments.count).to eql(5)
    end
  end
end
