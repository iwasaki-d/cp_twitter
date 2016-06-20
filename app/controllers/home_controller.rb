class HomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    if user_signed_in?
      redirect_to user_url(current_user)
    end
  end

  private

  def set_user
    @user = current_user || User.new
  end

end
