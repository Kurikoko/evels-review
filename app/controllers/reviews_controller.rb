class ReviewsController < ApplicationController
  before_action :set_place_params, only:[:new, :create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    unless @review.save
      render :new
    end  
  end

  def destroy
    review = Review.find(params[:id])
    if review.destroy
      redirect_to place_path(@place)
    end
  end

  private
  def review_params
    params.require(:review).permit(:upload, :download, :text, :image, :comment).merge(user_id: current_user.id, place_id: params[:place_id])
  end

  def set_place_params
    @place = Place.find(params[:place_id])
  end
end
