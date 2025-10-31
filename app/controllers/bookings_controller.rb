class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:format])
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
    # find booking to be cancelled
    @booking = Booking.find(params[:format])
    # change booking status to cancel
    @booking.update(status: 'cancelled')
    redirect_to bookings_index_path, notice: 'Booking cancelled!'
  end

  def accept
    @booking = Booking.find(params[:format])
    @booking.update(status: 'accepted')
    redirect_to bookings_index_path, notice: 'Booking accepted'
  end

  def reject
    @booking = Booking.find(params[:format])
    @booking.update(status: 'rejected')
    redirect_to bookings_index_path, notice: 'Booking rejected'
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pick_up_address, :dropoff_address, :total_price, :status, :payment_status, :vehicle_is, :user_id )
  end

end
