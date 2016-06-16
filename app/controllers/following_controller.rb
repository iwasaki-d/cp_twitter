class FollowingController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_following, only: [:update, :destroy]

  def create
    @following = Following.new(following_params)
    if @following.save
      redirect_to :back, notice: 'フォローしました。'
    else
      redirect_to :back, alert: 'フォローに失敗しました。'
    end
  end

  def destroy
    @following.destroy
    redirect_to :back, notice: 'フォローを解除しました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_following
    @following = current_user.my_following_relationship.find_by(following_user_id:params[:following_user_id])
  end

  def following_params
    {user_id: current_user.id}.merge params.require(:following).permit(:following_user_id)
  end


end
