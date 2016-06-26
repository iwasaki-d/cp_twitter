class LikesController < ApplicationController
  before_action :set_like, only: [:create, :destroy, :users_list]
  before_action :set_tweet, only: [:create, :destroy, :users_list]

  def users_list
    @users = @tweet.like_users.page(params[:users_page]).per(Constants::LIKE_USERS_PAR)
  end

  def create
    @like.save!
    respond_to do |format|
      @tweet.reload # like.js.erb表示の為にcounter_cacheの更新を反映させて最新の状態にする
      format.js { render 'like' }
    end
  end

  def destroy
    @like.destroy!
    respond_to do |format|
      @tweet.reload # createの同処理と同様
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
