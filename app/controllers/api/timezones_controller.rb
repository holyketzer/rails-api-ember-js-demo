class Api::TimezonesController < ApplicationController
  respond_to :json

  doorkeeper_for :all
  before_action :load_user
  before_action :load_timezone, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    respond_with @current_user.timezones
  end

  def show
    respond_with @timezone
  end

  def create
    @timezone = @current_user.timezones.create(timezone_params)
    if @timezone.valid?
      respond_with @timezone, location: api_timezone_url(@timezone)
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def update
    @timezone.update_attributes(timezone_params)
    if @timezone.valid?
      respond_with @timezone
    else
      render json: { errors: @timezone.errors }, status: 422
    end
  end

  def destroy
    respond_with @timezone.destroy
  end

  private

  def timezone_params
    params.require(:timezone).permit(:name, :city, :gmt)
  end

  def load_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  def load_timezone
    @timezone = @current_user.timezones.find(params[:id])
  end

  def record_not_found
    render text: '404 Not Found', status: 404
  end
end