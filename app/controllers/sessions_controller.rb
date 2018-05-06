# frozen_string_literal: true

# Class defines how to create and destroy sessions
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if check_user_authorization?(user)
      flash[:success] = 'You have successfully logged in.'
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There was something wrong with your login
                            information."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have successfully logged out.'
    redirect_to root_path
  end

  private

  def check_user_authorization?(user)
    user&.authenticate(params[:session][:password])
    session[:user_id] = user.id
  end
end
