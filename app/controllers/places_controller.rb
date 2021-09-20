class PlacesController < ApplicationController
  
  def index
    @places = Place.all.order(created_at: :DESC)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.create(place_params)
    if @place.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def place_params
    params.require(:place).permit(:image,:area_id,:place_name)
  end
end
