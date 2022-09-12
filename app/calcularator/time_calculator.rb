class TimeCalculator
  def self.travel_minute(point1, point2, speed)
    kilometer = point1.distance_to(point2)
    
    kilometer * 60 / speed
  end
end
