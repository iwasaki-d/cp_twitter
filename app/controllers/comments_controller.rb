class CommentsController < ApplicationController
  before_action :set_commented_user, only: %i(index create destroy)
  before_action :set_commented_tweet, only: %i(index create destroy)
  before_action :set_comment, only: %i(create destroy)

  def index
    @comments = @commented_tweet.comments.order_latest
                  .page(params[:comments_page]).per(Constants::COMMENT_TWEETS_PAR)
    respond_to do |format|
      format.js { render 'index' }
    end
  end

  def create
    @comment.parent = @commented_tweet
    @comment.body = comment_params[:body]
    @comment.save!
    index
  end

  def destroy
    @comment.destroy!
    index
  end

  private

  def set_commented_user
    @commented_user = User.find_by_param(params[:user_id])
  end

  def set_commented_tweet
    @commented_tweet = @commented_user.tweets.find(params[:tweet_id])
  end

  def set_comment
    @comment = current_user.tweets.find_or_initialize_by(id: params[:id])
  end

  def comment_params
    params.require(:tweet).permit(:body)
  end

end
