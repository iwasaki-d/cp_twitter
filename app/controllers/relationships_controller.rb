class RelationshipsController < ApplicationController
  before_action :set_user, only: [:index]
  before_action :set_relationship, only: [:update, :destroy]

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      redirect_to :back, notice: 'フォローしました。'
    else
      redirect_to :back, alert: 'フォローに失敗しました。'
    end
  end

  def destroy
    @relationship.destroy
    redirect_to :back, notice: 'フォローを解除しました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_relationship
    @relationship = current_user.my_following_relationships.find_by(following_user_id: params[:following_user_id])
  end

  def relationship_params
    {user_id: current_user.id}.merge params.require(:relationship).permit(:following_user_id)
  end


end
