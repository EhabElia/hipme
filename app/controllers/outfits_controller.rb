class OutfitsController < ApplicationController
  before_action :set_outfit, only: [:show, :edit, :update, :destroy]
  before_action :set_style_and_sizes, only: [:new, :edit]
  def index
    @outfits = Outfit.all
  end

  def show
  end

  def new
    @outfit = Outfit.new
  end

  def create
    @outfit = Outfit.new(outfit_params)
    if @outfit.save
      redirect_to outfit_path(@outfit)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @outfit.update(outfit_params)
    redirect_to outfits_path
  end

  def destroy
    @outfit.destroy
    redirect_to outfits_path
  end

  private

  def outfit_params
    params.require(:outfit).permit(:title, :description, :price, :size, :style)
  end

  def set_outfit
    @outfit = Outfit.find(params[:id])
  end

  def set_style_and_sizes
    @styles = Outfit::ALL_STYLES
    @sizes = Outfit::ALL_SIZES
  end

end
