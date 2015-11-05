class BookingsController < ApplicationController
  before_action :set_outfit
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @outfit.bookings.new(booking_params)
    @booking.user = current_user
    @booking.total_price = (@booking.checkout - @booking.checkin) * @outfit.price
    if @booking.save
      redirect_to outfit_booking_path(@outfit, @booking)
    else
      render :new
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:checkin, :checkout)
  end

  def set_outfit
    @outfit = Outfit.find(params[:outfit_id])
  end

  # def set_references
  #   @booking.outfit_id = @outfit.id
  #   @booking.user_id = current_user.id
  # end

end
