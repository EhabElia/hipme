class OutfitsController < ApplicationController
  before_action :set_outfit, only: [:show, :edit, :update, :destroy]
  def index
    @outfits = Outfit.all
  end

  def show
  end

  def new
    @outift = Outfit.new
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
  end

  def destroy
  end

  private

  def outfit_params
    params.require(:outfits).permit(:title, :description, :price, :size, :type)
  end

  def set_outfit
    @outfit = Outfit.find(params[:id])
  end
end

