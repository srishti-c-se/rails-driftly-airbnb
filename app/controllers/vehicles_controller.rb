class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end

  def show
    @vehicle = Vehicle.find(params[:id])
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.save
    redirect_to vehicles_path(@vehicles), notice: 'Vehicle was successfully added.'
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def nearby
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:title, :brand, :model, :year, :address, :price_per_day, :seats, :transmission, :fuel_type, :description)
  end
end
