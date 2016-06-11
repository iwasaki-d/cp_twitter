class TwitterController < ApplicationController
  before_action :set_twitter, only: [:show, :edit, :update, :destroy]

  # GET /twitter
  # GET /twitter.json
  def index
    @twitter = Twitter.all
  end

  # GET /twitter/1
  # GET /twitter/1.json
  def show
  end

  # GET /twitter/new
  def new
    @twitter = Twitter.new
  end

  # GET /twitter/1/edit
  def edit
  end

  # POST /twitter
  # POST /twitter.json
  def create
    @twitter = Twitter.new(twitter_params)

    respond_to do |format|
      if @twitter.save
        format.html { redirect_to @twitter, notice: 'Twitter was successfully created.' }
        format.json { render :show, status: :created, location: @twitter }
      else
        format.html { render :new }
        format.json { render json: @twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitter/1
  # PATCH/PUT /twitter/1.json
  def update
    respond_to do |format|
      if @twitter.update(twitter_params)
        format.html { redirect_to @twitter, notice: 'Twitter was successfully updated.' }
        format.json { render :show, status: :ok, location: @twitter }
      else
        format.html { render :edit }
        format.json { render json: @twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitter/1
  # DELETE /twitter/1.json
  def destroy
    @twitter.destroy
    respond_to do |format|
      format.html { redirect_to twitter_index_url, notice: 'Twitter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter
      @twitter = Twitter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitter_params
      params.require(:twitter).permit(:text, :user_id)
    end
end
