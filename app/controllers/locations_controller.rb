class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /locations/1
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  def date
    @creator = Account.find(params[:creator_id])
    @recipient = Account.find(params[:recipient_id])
    if Location.find_by(creator_id: @creator.id,recipient_id: @recipient.id).nil?
      @location = Location.new
    else
      @location = Location.find_by(creator_id: @creator.id,recipient_id: @recipient.id)
      redirect_to "/show_date/#{@location.id}"
    end
  end

  def create
    @location = Location.create(street: params[:street], city: params[:city], country: params[:country], creator_id: params[:creator_id], recipient_id: params[:recipient_id], time_of_date: Time.parse(params[:time_of_date]["{:value=>\"%H:%M\"}"]))

    redirect_to "/show_date/#{@location.id}", notice: "Location was successfully created."
  end

  def dates
    locations = Location.where(creator_id: current_account.id).or(Location.where(recipient_id: current_account.id))
    @dates = Locations::GetLocationData.call(locations: locations)
    @current_account_id = current_account.id
  end

  def approve_date
    Location.find(params[:id]).update responsed: "approved"

    redirect_to dates_path
  end

  def decline_date
    Location.find(params[:id]).update responsed: "declined"

    redirect_to dates_path
  end

  def destroy
    @location = Location.find(params[:id])
  end
  def show_date
    @location = Location.find(params[:date_id])
  end
end
