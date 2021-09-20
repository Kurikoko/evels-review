class PlacesController < ApplicationController
  
  before_action :set_params, only: [:show]

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

  def show
  end

  private
  def place_params
    params.require(:place).permit(:image,:area_id,:place_name, :carrier, :line_kinds_id, :fee_id, :backup_line_id, :wifi_id)
  end

  def set_params
    @place = Place.find(params[:id])
  end
end
