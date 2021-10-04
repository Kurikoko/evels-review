class ReviewsController < ApplicationController
  before_action :authenticate_user!, only:[:new,:edit,:destroy]
  before_action :set_place_params, only:[:new, :create, :edit, :destroy]
  before_action :set_review_params, only: [:edit, :update, :destroy]
  before_action :redirect_different_user, only: [:edit, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to place_path(@review.place_id)
    else
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

  def redirect_different_user
    redirect_to root_path unless current_user.id == @review.user_id
  end

end
