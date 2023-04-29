class Locations::GetTime
  include Callable

  def initialize(time:, coordinates:)
    @time = time
    @coordinates = coordinates
  end

  def call
    {
      time: time_in_time_zone,
      timezone: timezone.name[:zone]
    }
  end

  private

  attr_reader :time, :coordinates

  def time_in_time_zone
    time.in_time_zone(timezone.name[:zone])
  end

  def place
    country_code = Geocoder.search(coordinates).last.data["address"]["country_code"]
    TZInfo::Country.get(country_code.upcase)
  end

  def timezone
    Timezone::Zone.new zone:place.zone_names.last
  end
end