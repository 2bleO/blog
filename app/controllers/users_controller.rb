class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order('id')
  end

  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(author_id: @user.id).includes(:comments)
  end
end
