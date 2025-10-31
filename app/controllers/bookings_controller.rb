class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.save
    redirect_to bookings_index_path, notice: 'Booking added!'
  end

  def cancel
  end

  def accept

  end

  def reject
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pick_up_address, :dropoff_address, :total_price, :status, :payment_status, :vehicle_title )
  end

end
