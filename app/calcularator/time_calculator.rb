class TimeCalculator
  def self.travel_minute(coordinates1, coordinates2, speed)
    kilometer = Geocoder::Calculations.distance_between(coordinates1, coordinates2)

    kilometer * 60 / speed
  end
end
