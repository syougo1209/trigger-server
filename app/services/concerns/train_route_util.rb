module TrainRouteUtil
  class << self
    def stop_stations_code(train_route)
      train_route.first[:lines].map do |line|
        line[:stop_stations].map { |sta| sta[:station_code] }
      end.flatten
    end
  end
end
