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
    @location = Location.create(street: params[:street], city: params[:city], country: params[:country], creator_id: params[:creator_id], recipient_id: params[:recipient_id])
    time_hash = Locations::GetTime.call(time: Time.now, coordinates: [@location.latitude, @location.longitude])
    timezone = time_hash[:timezone]
    Location.find_by(id: @location.id).update time_of_date: Time.parse(params[:time_of_date]["{:value=>\"%H:%M\"}"]), timezone: timezone
    redirect_to "/show_date/#{@location.id}", notice: "Location was successfully created."
  end

  def check_dates
    return if !Location.where(responsed: "approved").exists?

    Location.where(responsed: "approved").each do |location|
      time_hash = Locations::GetTime.call(time: Time.now, coordinates: [location.latitude, location.longitude])
      # current time that we change in time of place where will date
      current_time_in_date_timezone = time_hash[:time]
      # we set date in timezone of place where will date
      time_of_date = change_timezone(time: location.time_of_date, timezone: location.timezone)
      if current_time_in_date_timezone > time_of_date
        location.update responsed: "closed"
      end
    end
  end

  def dates
    locations = Location.where(creator_id: current_account.id).or(Location.where(recipient_id: current_account.id))
    @dates = Locations::GetLocationData.call(locations: locations)
    @current_account_id = current_account.id
  end

  def approve_date
    location = Location.find(params[:id])
    time_hash = Locations::GetTime.call(time: Time.now, coordinates: [location.latitude, location.longitude])
    # current time that we change in time of place where will date
    current_time_in_date_timezone = time_hash[:time]
    # we set date in timezone of place where will date
    time_of_date = change_timezone(time: location.time_of_date, timezone: location.timezone)
    if current_time_in_date_timezone > time_of_date
      location.update responsed: "closed"
    else
      location.update responsed: "approved"
    end

    redirect_to dates_path
  end

  def decline_date
    location = Location.find(params[:id])
    time_hash = Locations::GetTime.call(time: Time.now, coordinates: [location.latitude, location.longitude])
    # current time that we change in time of place where will date
    current_time_in_date_timezone = time_hash[:time]
    # we set date in timezone of place where will date
    time_of_date = change_timezone(time: location.time_of_date, timezone: location.timezone)
    if current_time_in_date_timezone > time_of_date
      location.update responsed: "closed"
    else
      location.update responsed: "declined"
    end

    redirect_to dates_path
  end

  def destroy
    @location = Location.find(params[:id])
  end
  def show_date
    @location = Location.find(params[:date_id])
    @timezone = change_timezone(time: Time.now, timezone: @location.timezone).strftime("%:z UTC")
  end

  private

  def change_timezone(time:, timezone:)
    ActiveSupport::TimeZone[timezone].parse(time.asctime)
  end
end
