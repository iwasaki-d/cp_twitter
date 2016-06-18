class UsersController < ApplicationController
  before_action :set_user

  def show
    if @user == current_user
      @tweets = current_user.timeline
    else
      @tweets = @user.tweets
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
