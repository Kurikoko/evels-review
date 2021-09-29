class UsersController < ApplicationController
  def show
    @user_reviews = current_user.reviews.order(created_at: :DESC).page(params[:page]).per(3)
  end
end
