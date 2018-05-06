# frozen_string_literal: true

# This class defines how user objects behave
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update destroy]
  before_action :require_admin, only: %i[destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the blog, #{@user.username}."
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully.'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User and all associated articles have been deleted.'
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return true unless current_user != @user && !current_user.admin?
    flash[:danger] = 'You can only edit your own account.'
    redirect_to root_path
  end

  def require_admin
    return true unless logged_in? && !current_user.admin?
    flash[:danger] = 'Only admins can delete users.'
    redirect_to root_path
  end
end
