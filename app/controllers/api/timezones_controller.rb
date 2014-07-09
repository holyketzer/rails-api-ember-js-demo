class Api::TimezonesController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  def index
    respond_with current_user.timezones
  end

  def show
    respond_with current_user.timezones.find(params[:id])
  end

  def create
    @timezone = current_user.timezones.create(timezone_params)
    if @timezone.valid?
      respond_with @timezone, location: api_timezone_url(@timezone)
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def update
    @timezone = current_user.timezones.find(params[:id])
    @timezone.update_attributes(timezone_params)
    if @timezone.valid?
      respond_with @timezone
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def destroy
    @timezone = current_user.timezones.find(params[:id])
    respond_with @timezone.destroy
  end

  private

  def timezone_params
    params.require(:timezone).permit(:name, :city, :gmt)
  end
end