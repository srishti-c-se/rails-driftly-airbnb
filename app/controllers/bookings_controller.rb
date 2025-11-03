class BookingsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :cancel]
  before_action :set_vehicle, only: [:new, :create]
  before_action :authorize_user!, only: [:cancel]

  def index
    @bookings = current_user.bookings
  end

  def show
  end

  def new
    # directly attached it to a specific vehicle
    @booking = @vehicle.bookings.new
  end

  def create
    @booking = @vehicle.bookings.new(booking_params)
    @booking.user = current_user
    @booking.status = :pending
    @booking.payment_status = :unpaid
    # @booking.total_price = @booking.calculate_total_price
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking requested successfully!"
    else
      flash.now[:alert] = @booking.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def cancel
    if @booking.pending? || @booking.accepted?
      @booking.update(status: :cancelled)
      redirect_to bookings_path, notice: "Booking cancelled successfully."
    else
      redirect_to bookings_path, alert: "Cannot cancel this booking."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pickup_address, :dropoff_address)
  end

  # Ensure only the user who created the booking can cancel it
  def authorize_user!
    redirect_to bookings_path, alert: "Not authorized" unless @booking.user == current_user
  end
end
