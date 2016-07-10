class RelationshipsController < ApplicationController
  before_action :set_following_relationship, only: [:create, :destroy]

  def create
    if @following_relationship.save
      redirect_to :back, notice: 'フォローしました。'
    else
      redirect_to :back, alert: 'フォローに失敗しました。'
    end
  end

  def destroy
    @following_relationship.destroy!
    redirect_to :back, notice: 'フォローを解除しました。'
  end

  private

  def set_following_relationship
    @following_relationship = current_user.following_relationships.find_or_initialize_by(following_user_id: params[:user_id])
  end


end
