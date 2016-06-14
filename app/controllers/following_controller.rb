class FollowingController < ApplicationController
  before_action :set_following, only: [:show, :edit, :update, :destroy]

  # GET /following
  # GET /following.json
  def index
    @following = Following.all
  end

  # GET /following/1
  # GET /following/1.json
  def show
  end

  # GET /following/new
  def new
    @following = Following.new
  end

  # GET /following/1/edit
  def edit
  end

  # POST /following
  # POST /following.json
  def create
    @following = Following.new(following_params)

    respond_to do |format|
      if @following.save
        format.html { redirect_to @following, notice: 'Following was successfully created.' }
        format.json { render :show, status: :created, location: @following }
      else
        format.html { render :new }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /following/1
  # PATCH/PUT /following/1.json
  def update
    respond_to do |format|
      if @following.update(following_params)
        format.html { redirect_to @following, notice: 'Following was successfully updated.' }
        format.json { render :show, status: :ok, location: @following }
      else
        format.html { render :edit }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /following/1
  # DELETE /following/1.json
  def destroy
    @following.destroy
    respond_to do |format|
      format.html { redirect_to following_index_url, notice: 'Following was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:following).permit(:user_id, :following_user_id)
    end
end
