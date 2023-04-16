class Location < ApplicationRecord
  belongs_to :creator, class_name: 'Account'
  belongs_to :recipient, class_name: 'Account'

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  def address
    [street, city, country].compact.join(", ")
  end
  def address_changed?
    street_changed?||city_changed?||country_changed?
  end
end
