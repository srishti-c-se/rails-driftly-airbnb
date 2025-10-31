class Owner::BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :accept, :reject]
  before_action :authorize_renter!

  def index
    @bookings = Booking.joins(:vehicle)
                        .where(vehicles: { user_id: current_user.id })
                        .order(start_date: :desc)
  end

  # to show any booking for the owner’s vehicles, even if the user who booked it is someone else
  def show
  end

  def accept
    if @booking.pending?
      @booking.update(status: :accepted)
      redirect_to owner_bookings_path, notice: "Booking accepted!"
    else
      redirect_to owner_bookings_path, alert: "Cannot accept this booking."
    end
  end

  def reject
    if @booking.pending?
      @booking.update(status: :rejected)
      redirect_to owner_bookings_path, notice: "Booking rejected."
    else
      redirect_to owner_bookings_path, alert: "Cannot reject this booking."
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Only allow renter to manage bookings for their vehicles
  def authorize_renter!
    unless current_user.renter? && @booking.vehicle.user_id == current_user.id
      redirect_to root_path, alert: "Not authorized"
    end
  end
end
