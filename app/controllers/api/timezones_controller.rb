class Api::TimezonesController < ApplicationController
  respond_to :json

  before_action :authenticate_user!

  def index
    respond_with Timezone.all
  end

  def show
    respond_with Timezone.find(params[:id])
  end

  def create
    @timezone = Timezone.create(timezone_params)
    if @timezone.valid?
      respond_with @timezone, location: api_timezone_url(@timezone)
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def update
    @timezone = Timezone.update(params[:id], timezone_params)
    if @timezone.valid?
      respond_with @timezone
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def destroy
    respond_with Timezone.destroy(params[:id])
  end

  private

  def timezone_params
    params.require(:timezone).permit(:name, :city, :gmt)
  end
end