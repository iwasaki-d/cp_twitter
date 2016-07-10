class TweetsController < ApplicationController
  before_action :set_user
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_current_user, only: [:edit, :update, :destroy]

  def index
    @tweets = @user.tweets.order_latest.page(params[:tweets_page]).per(Constants::DEFAULT_TWEETS_PAR)
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @tweet = current_user.tweets.build
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      redirect_to user_tweets_path(current_user), notice: 'ツイートしました。'
    else
      render :new
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to user_tweets_path(current_user), notice: 'ツイートを変更しました。'
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy!
    redirect_to user_tweets_path(current_user), notice: 'ツイートを削除しました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def authenticate_current_user
    unless @tweet.user == current_user
      redirect_to root_path, alert: '異なるユーザーのツイートを操作することはできません。'
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end

end
