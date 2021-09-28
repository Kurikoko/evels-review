class ReviewsController < ApplicationController
  before_action :set_place_params, only:[:new, :create, :edit, :destroy]
  before_action :set_review_params, only: [:edit, :update, :destroy]

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
    if @review.destroy
      redirect_to place_path(@place)
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to place_path(@review.place_id)
    else  
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit(:upload, :download, :text, :image, :comment).merge(user_id: current_user.id, place_id: params[:place_id])
  end

  def set_place_params
    @place = Place.find(params[:place_id])
  end

  def set_review_params
    @review = Review.find(params[:id])
  end

end
