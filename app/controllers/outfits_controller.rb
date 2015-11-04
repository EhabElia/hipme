class OutfitsController < ApplicationController
  before_action :set_outfit, only: [:show, :edit, :update, :destroy]
  before_action :set_style_and_sizes, only: [:new, :edit]

  def index
    @outfits = Outfit.all
    @markers = Gmaps4rails.build_markers(@outfits) do |outfit, marker|
      marker.lat outfit.latitude
      marker.lng outfit.longitude
    end
  end

  def show
    @outfit = Outfit.find(params[:id])
    @alert_message = "You are viewing #{@outfit.name}"
  end

  def new
    @outfit = Outfit.new
  end

  def create
    @outfit = current_user.outfits.new(outfit_params)
    if @outfit.save
      redirect_to user_outfit_path(@outfit.user, @outfit)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @outfit.update(outfit_params)
    redirect_to user_outfit_path(@outfit.user, @outfit)
  end

  def destroy
    @outfit.delete
    redirect_to edit_user_registration_path(@outfit.user)
  end

  private

  def outfit_params
    params.require(:outfit).permit(:title, :description, :price, :size, :style, :picture)
  end

  def set_outfit
    @outfit = Outfit.find(params[:id])
  end

  def set_style_and_sizes
    @styles = Outfit::ALL_STYLES
    @sizes = Outfit::ALL_SIZES
  end

end
