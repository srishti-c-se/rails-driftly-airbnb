class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:new, :create]
  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @booking = Booking.new
    @bookings = @vehicle.bookings.where(user: current_user)
    @reviews = @vehicle.reviews.includes(:user) # show reviews with users
    @review = Review.new # to pass to the form
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.user = current_user
    @vehicle.save
    redirect_to vehicles_path(@vehicles), notice: 'Vehicle was successfully added.'
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    @vehicle.update(vehicle_params)
    redirect_to vehicle_path(@vehicle)
  end

  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.destroy
    redirect_to vehicles_path, status: :see_other, notice: 'Vehicle was deleted.'
  end

  def nearby
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:title, :brand, :model, :year, :address, :price_per_day, :seats, :transmission, :fuel_type, :description)
  end
end
