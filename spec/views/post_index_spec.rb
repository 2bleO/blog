require 'rails_helper'

RSpec.describe 'Post view', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'Post index' do
    before do
      visit new_user_session_path
      User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
                  confirmed_at: Date.today)
      User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2',
                  bio: 'Hello Im User2.', confirmed_at: Date.today)

      5.times do |j|
        post = Post.create(title: "Post ##{j + 1}", text: "This is post #{j + 1}", author: User.second)
        Comment.create(text: 'Comment1', post: post, author: User.first)
        Comment.create(text: 'Comment2', post: post, author: User.second)
      end

      fill_in 'Email', with: 'test@user.com'
      fill_in 'Password', with: 'testu1'
      click_button 'Log in'
      visit "/users/#{User.second.id}/posts/"
    end

    it 'displays the author`s username.' do
      expect(page).to have_content('TestUser')
    end

    it 'displays the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 5')
    end

    it "displays the post's title." do
      expect(page).to have_content('Post #1')
    end

    it "displays some of the post's body." do
      expect(page).to have_content('This is post')
    end

    it 'display All comments on the post.' do
      expect(page).to have_content('Comment1')
      expect(page).to have_content('Comment2')
    end

    it 'display how many comments a post has.' do
      expect(page).to have_content('Comments: 2')
    end

    it 'display how many likes a post has.' do
      expect(page).to have_content('Likes: 0')
    end

    it 'display pagination button.' do
      expect(page).to have_selector 'button', text: 'Pagination'
    end

    it "should redirected to that user's show page, when click on a user" do
      click_link 'Post #1'
      expect(page).to have_current_path(user_post_path(User.second.id, User.second.posts.first.id))
    end
  end
end
