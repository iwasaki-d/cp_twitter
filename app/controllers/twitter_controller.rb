class TwitterController < ApplicationController
  before_action :set_twitter, only: [:show, :edit, :update, :destroy]

  def index
    @twitter = Twitter.all
  end

  def show
  end

  def new
    @twitter = Twitter.new
  end

  def edit
  end

  def create
    @twitter = Twitter.new(twitter_params)

    if @twitter.save
      redirect_to @twitter, notice: 'Twitter was successfully created.'
    else
      render :new
    end
  end

  def update
    if @twitter.update(twitter_params)
      redirect_to @twitter, notice: 'Twitter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @twitter.destroy
    redirect_to twitter_index_url, notice: 'Twitter was successfully destroyed.'
  end

  private

    def set_twitter
      @twitter = Twitter.find(params[:id])
    end

    def twitter_params
      params.require(:twitter).permit(:text, :user_id)
    end
end
