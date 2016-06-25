class LikesController < ApplicationController
  before_action :set_like, only: [:create, :destroy, :users_list]
  before_action :set_tweet, only: [:create, :destroy, :users_list]
  def users_list
    @users = @tweet.like_users.page(params[:users_page]).per(Constants::LIKE_USERS_PAR)
  end

  def create
    @like.save!
    @tweet = @like.tweet
    respond_to do |format|
      format.js { render 'like' }
    end
  end

  def destroy
    @like.destroy!
    respond_to do |format|
      @tweet.reload
      format.js { render 'like' }
    end
  end

  private

  def set_like
    @like = current_user.likes.find_or_initialize_by(tweet_id: params[:tweet_id])
  end

  def set_tweet
    @tweet = @like.tweet
  end


end
