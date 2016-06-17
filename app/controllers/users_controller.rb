class UsersController < ApplicationController
  before_action :set_user
  before_action :set_relationship

  def show
    if @user == current_user
      @tweets = current_user.get_tweets_include_tweets_of_following
    else
      @tweets = @user.tweets
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_relationship
    @relationship = current_user.following_relationships.find_by(following_user_id: params[:id])
  end

end
