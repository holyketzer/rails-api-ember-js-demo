class Api::TimezonesController < ApplicationController
  respond_to :json

  def index
    respond_with Timezone.all
  end

  def show
    respond_with Timezone.find(params[:id])
  end

  def create
    @timezone = Timezone.create(timezone_params)
    respond_with @timezone, location: api_timezone_url(@timezone)
  end

  def update
    respond_with Timezone.update(params[:id], timezone_params)
  end

  def destroy
    respond_with Timezone.destroy(params[:id])
  end

  private

  def timezone_params
    params.require(:timezone).permit(:name, :city, :gmt)
  end
end