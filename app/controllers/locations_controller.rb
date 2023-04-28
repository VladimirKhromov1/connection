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
    if Location.find_by(creator_id: @creator.id,recipient_id: @recipient.id, responsed: "default").nil?
      @location = Location.new
    else
      @location = Location.find_by(creator_id: @creator.id,recipient_id: @recipient.id, responsed: "default")
      redirect_to "/show_date/#{@location.id}"
    end
  end

  def create
    @location = Location.create(street: params[:street], city: params[:city], country: params[:country], creator_id: params[:creator_id], recipient_id: params[:recipient_id], time_of_date: DateTime.parse(params[:time_of_date]["{:value=>\"%H:%M\"}"]).in_time_zone("Minsk"))

    redirect_to "/show_date/#{@location.id}", notice: "Location was successfully created."
  end

  def check_dates
    Location.where(responsed: "approved").each do |date|
      date.update responsed: "closed" if Time.now.in_time_zone("Minsk") > date.time_of_date.time_of_date.in_time_zone("Minsk")
    end
  end

  def dates
    locations = Location.where(creator_id: current_account.id).or(Location.where(recipient_id: current_account.id))
    @dates = Locations::GetLocationData.call(locations: locations)
    @current_account_id = current_account.id
  end

  def approve_date
    if Time.now.in_time_zone("Minsk") > Location.find(params[:id]).time_of_date.time_of_date.in_time_zone("Minsk")
      Location.find(params[:id]).update responsed: "closed"
    else
      Location.find(params[:id]).update responsed: "approved"
    end

    redirect_to dates_path
  end

  def decline_date
    if Time.now.in_time_zone("Minsk") > Location.find(params[:id]).time_of_date.time_of_date.in_time_zone("Minsk")
      Location.find(params[:id]).update responsed: "closed"
    else
      Location.find(params[:id]).update responsed: "declined"
    end

    redirect_to dates_path
  end

  def destroy
    @location = Location.find(params[:id])
  end
  def show_date
    @location = Location.find(params[:date_id])
  end
end
