require 'rails_helper'

RSpec.describe 'User view', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'User show page' do
    before do
      visit home_path
      User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
                  confirmed_at: Date.today)
      User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2',
                  posts_counter: 3, bio: 'Hello Im User2.', confirmed_at: Date.today)
      fill_in 'Email', with: 'test@user.com'
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

    it "should redirects me to the user's post's index page, when click on a see all posts button" do
      click_link 'See all post'
      expect(page).to have_current_path(user_posts_path(User.second.id))
    end
  end
end
