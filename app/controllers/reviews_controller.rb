class ReviewsController < ApplicationController
  before_action :set_vehicle
  before_action :authenticate_user!

  def create
    # find a completed booking for this user and vehicle
    @booking = current_user.bookings.find_by(vehicle: @vehicle, status: "completed")
    # Booking is optional, but user must have at least one completed booking for that vehicle
    unless @booking
      redirect_to vehicle_path(@vehicle), alert: "You can only review a vehicle after completing a booking."
      return
    end

    @review = @vehicle.reviews.new(review_params)
    @review.user = current_user
    @review.booking = @booking

    if @review.save
      redirect_to vehicle_path(@vehicle), notice: "Review created!"
    else
      redirect_to vehicle_path(@vehicle), alert: @review.errors.full_messages.to_sentence
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:vehicle_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
