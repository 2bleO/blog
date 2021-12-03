require 'rails_helper'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

RSpec.describe 'User view', type: :feature do
  describe 'User show page' do
    before do
      DatabaseCleaner.clean
      visit home_path
      User.create(name: 'TestUser1', email: 'test@user1.com', password: 'testu1', password_confirmation: 'testu1',
                  confirmed_at: Date.today)
      User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2',
                  bio: 'Hello Im User2.', confirmed_at: Date.today)
      3.times do |j|
        Post.create(title: "Post ##{j + 1}", text: "This is Post#{j + 1} by TestUser2", author: User.second)
      end

      fill_in 'Email', with: 'test@user1.com'
      fill_in 'Password', with: 'testu1'
      click_button 'Log in'
      click_link 'TestUser2'
    end

    it "should be able see user's username" do
      expect(page).to have_content('TestUser2')
    end

    it 'should be able see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts: 3')
    end

    it "should be able see the user's bio." do
      expect(page).to have_content('Hello Im User2.')
    end

    it "should see a button that lets me view all of a user's posts." do
      expect(page).to have_content('See all post')
    end

    it 'I can see the user\'s profile picture.' do
      expect(page).to have_css('img.users-image')
    end

    it 'I can see the user\'s first 3 posts.' do
      expect(page).to have_content('This is Post1 by TestUser2')
      expect(page).to have_content('This is Post2 by TestUser2')
      expect(page).to have_content('This is Post3 by TestUser2')
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page.' do
      click_link 'Post #1'
      expect(page).to have_content('Post #1 by TestUser2')
      expect(page).to have_content('This is Post1 by TestUser2')
    end

    it "should redirects me to the user's post's index page, when click on a see all posts button" do
      click_link 'See all post'
      expect(page).to have_current_path(user_posts_path(User.second.id))
    end
  end
end
