class CreateHotelToHomePlanService
  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    @hotel = Hotel.near(@current_coordinates, 10, unit: :km).first

    detail1 = create_walk_detail
    detail2 = create_hotel_detail
    detail3 = create_train_detail
    detail4 = create_home_nearest_station_detail

    Plan.new(details: [detail1, detail2, detail3, detail4])
  end

  private

  def create_walk_detail
    minute = TimeCalculator.travel_minute(@current_coordinates, @hotel, 4)
    next_action = NextAction.new(method: 'walk', price: 0, required_minute: minute , physical_point: 10, train: Train.new)
    Detail.new(name: '現在地', next_action: next_action, leave_at: nil, arrive_at: nil, place_genre: 'position')
  end

  def create_hotel_detail
    @current_nearest_station = Station.near(@current_coordinates, 10, unit: :km).first
    minute = TimeCalculator.travel_minute(@current_nearest_station, @hotel, 4)

    next_action = NextAction.new(method: 'walk', price: 0, required_minute: minute , physical_point: 10, train: Train.new)
    Detail.new(name: @hotel.name, price: @hotel.price, next_action: next_action, leave_at: nil, arrive_at: nil, place_genre: 'hotel')
  end

  def create_train_detail
    home_nearest_station = Station.near(@home_coordinates, 10, unit: :km).first

    @train_route = TrainRouteClient.request(station_code_from: @current_nearest_station.code, station_code_to: home_nearest_station.code, is_next_day: true)
    line_info = @train_route[0][:lines][0]
    train = Train.new(line: line_info[:name], direction: line_info[:direction], track: line_info[:track])
    required_minute =  (@train_route[0][:arrive_at] - @train_route[0][:leave_at])/60

    next_action = NextAction.new(method: 'train', price: line_info[:price], required_minute: required_minute, physical_point: 200, train: train)
    Detail.new(name: @current_nearest_station.name, next_action: next_action, leave_at: @train_route[0][:leave_at], arrive_at: nil, place_genre: 'station')
  end

  def create_home_nearest_station_detail
    next_action = NextAction.new(train: Train.new)
    Detail.new(name: @train_route.last[:to][:station_name], next_action: next_action, leave_at: nil, arrive_at: @train_route[0][:arrive_at], place_genre: 'station')
  end
end
