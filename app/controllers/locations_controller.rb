class LocationsController < ApplicationController
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
    @location = Location.create(street: params[:street], city: params[:city], country: params[:country], creator_id: params[:creator_id], recipient_id: params[:recipient_id])

    redirect_to "/show_date/#{@location.id}", notice: "Location was successfully created."
  end

  def show_date
    @location = Location.find(params[:date_id])
  end
end
