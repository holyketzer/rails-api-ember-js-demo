class Api::TimeZonesController < ApplicationController
  respond_to :json

  def index
    respond_with TimeZone.all
  end

  def show
    respond_with TimeZone.find(params[:id])
  end

  def create
    @time_zone = TimeZone.create(time_zone_params)
    respond_with @time_zone, location: api_time_zone_url(@time_zone)
  end

  def update
    respond_with TimeZone.update(params[:id], time_zone_params)
  end

  def destroy
    respond_with TimeZone.destroy(params[:id])
  end

  private

  def time_zone_params
    params.require(:time_zone).permit(:name, :city, :gmt)
  end
end