require 'rails_helper'

RSpec.describe 'the signin process', type: :feature do
  describe 'login page' do
    before do
      visit home_path
      User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
                  confirmed_at: Date.today)
    end

    it 'shows the username and password inputs' do
      expect(page).to have_css('input[type="email"]')
      expect(page).to have_css('input[type="password"]')
    end

    it 'shows the "Submit" button' do
      expect(page).to have_button('Log in')
    end

    it 'click the submit button without filling in the email and the password shows the Error message' do
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'filling email and password fields with incorrect data shows the Error message' do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password')
    end

    it 'filling email and password fields with correct data redirects to the root page' do
      fill_in 'Email', with: 'test@user.com'
      fill_in 'Password', with: 'testu1'
      click_button 'Log in'
      expect(page).to have_current_path(home_path)
    end
  end
end

RSpec.describe 'list of users in', type: :feature do
  describe 'user index page:' do
    before do
      visit home_path
      User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1', posts_counter: 3, confirmed_at: Date.today)
      User.create(name: 'TestUser2', email: 'test@user2.com', password: 'testu2', password_confirmation: 'testu2',
                  confirmed_at: Date.today)
      fill_in 'Email', with: 'test@user.com'
      fill_in 'Password', with: 'testu1'
      click_button 'Log in'
    end

    it 'I can see the username of all other users' do
      expect(page).to have_content('TestUser')
      expect(page).to have_content('TestUser2')
    end

    it 'should be able see the number of posts each user has written.' do
      expect(page).to have_content('Number of posts: 3')
    end

    it 'When I click on a user, I am redirected to that user\'s show page' do
      click_link 'TestUser'
      expect(page).to have_current_path(page.find_link('TestUser')[:href])
    end
  end
end