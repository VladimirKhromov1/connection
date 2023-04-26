class Locations::GetLocationData
  include Callable

  def initialize(locations:)
    @locations = locations
  end

  def call
    locations.map do |location|
      {
        id: location.id,
        creator: account(location.creator),
        recipient: account(location.recipient),
        responsed: location.responsed,
        timeOfDate: location.time_of_date.strftime("%I:%M %P")
      }
    end
  end

private

  attr_reader :locations

  def account(account)
    {
      id: account.id,
      email: account.email,
      username: account&.username,
      firstName: account&.first_name,
      lastName: account&.last_name,
      photo: avatar_path(account),
      age: account.age,
    }
  end

  def avatar_path(account)
    if account&.avatar&.blob.nil?
      'http://localhost:3000/default.png'
    else
      Rails.application.routes.url_helpers.rails_blob_url(account.avatar.blob, Rails.application.config.action_mailer.default_url_options)
    end
  end

end