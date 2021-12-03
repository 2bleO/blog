require 'rails_helper'

RSpec.describe 'Post view', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'Post show' do
    before do
      visit new_user_session_path
      User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1', confirmed_at: Date.today)
      User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2', bio: 'Hello Im User2.',
                  confirmed_at: Date.today)

      5.times do |j|
        post = Post.create(title: "Post ##{j + 1}", text: "This is post #{j + 1}", author: User.second)
        Comment.create(text: 'Comment1', post: post, author: User.first)
        Comment.create(text: 'Comment2', post: post, author: User.second)
      end

      fill_in 'Email', with: 'test@user.com'
      fill_in 'Password', with: 'testu1'
      click_button 'Log in'
      click_link 'TestUser2'
      click_link 'See all post'
      click_link 'Post #1'
    end

    it "displays the post's title." do
      expect(page).to have_content('Post #1')
    end

    it 'displays who wrote the post.' do
      expect(page).to have_content('Post #1 by TestUser2')
    end

    it 'display how many comments the post has.' do
      expect(page).to have_content("Comments: 2")
    end

    it 'display how many likes the post has.' do
      expect(page).to have_content("Likes: 0")
    end

    it 'display post`s body.' do
      expect(page).to have_content('This is post 1')
    end

    it 'display the username of each commentor.' do
      expect(page).to have_content('TestUser')
      expect(page).to have_content('TestUser2')
    end

    it 'display the comment each commentor left.' do
      expect(page).to have_content('Comment1')
      expect(page).to have_content('Comment2')
    end
  end
end