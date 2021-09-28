class PlacesController < ApplicationController
  
  before_action :set_params, only: [:show]
  before_action :set_q, only: [:search]
  def index
    @places = Place.all.order(created_at: :DESC).page(params[:page]).per(3)
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
    @reviews = Review.where( "place_id = #{@place.id}").order(created_at: :DESC).page(params[:page]).per(5)
    @reviews_all = Review.where( "place_id = #{@place.id}").order(created_at: :DESC)

    if @place.reviews.exists?(place_id: "#{@place.id}")
      @download_ave =  @reviews_all.average(:download).round(2)
      @upload_ave =  @reviews_all.average(:upload).round(2)
    end
  end

  def search
    @results = @q.result
  end

  private
  def place_params
    params.require(:place).permit(:image,:area_id,:place_name, :carrier, :line_kinds_id, :fee_id, :backup_line_id, :wifi_id)
  end

  def set_params
    @place = Place.find(params[:id])
  end

  def set_q
    @q = Place.ransack(params[:q])
  end
end
