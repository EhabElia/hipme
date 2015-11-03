class OutfitsController < ApplicationController
  before_action :set_outfit, only: [:show, :edit, :update, :destroy]
  def index
    @outfits = Outfit.all
  end

  def show
  end

  def new
    @outfit = Outfit.new
    @types = [ "Urban", "Hipster", "For a job interview", "For a night out" ]
    @sizes = [ "165cm", "170cm", "175cm", "180cm", "185cm", "190cm" ]
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
