require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) {  User.create(name: 'TestUser', email: 'test@user.com', password: 'testu1', password_confirmation: 'testu1',
  confirmed_at: Date.today) }

  describe 'GET #index' do
    before do
      sign_in user
      get users_path
    end

    it 'should have correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
  before do
    sign_in user
    get user_path(1)
  end

    it 'should have correct response status' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:show)
    end
  end
end
