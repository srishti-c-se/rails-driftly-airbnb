class BookingsController < ApplicationController
  before_action :set_vehicle, only: [:new, :create]
  before_action :set_booking, only: [:show]
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new
  end

  def new
    @booking = Booking.new
  end

  def create
    @vehicle = Vehicle.find(params[:vehicle_id])
    @booking = Booking.new(booking_params)
    @booking.vehicle = @vehicle
    @booking.user = current_user
    if @booking.save
      redirect_to vehicle_path(@vehicle), notice: 'Vehicle was successfully added.'
    else
      redirect_to vehicle_path, notice: "#{@vehicle.errors.full_messages.join(', ')}"
    end
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
    params.require(:booking).permit(:date, :start_date, :end_date, :pick_up_address, :dropoff_address, :total_price, :status, :payment_status, :vehicle_is, :user_id )
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
    @vehicle = @booking.vehicle
  end
end
