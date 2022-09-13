class TaxiCalculator
  def calc_travel_time(point1, point2)
    distance = point1.distance_to(point2)
    km_per_hour = 40
    distance * 60 / km_per_hour
  end
end
