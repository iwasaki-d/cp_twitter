class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_current_user

  def show
    @tweets = current_user.timeline
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authenticate_current_user
    unless @user == current_user
      redirect_to user_tweets_url(user_id: @user)
    end
  end

end
