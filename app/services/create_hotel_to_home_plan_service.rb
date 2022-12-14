class CreateHotelToHomePlanService
  WALK_SPEED = 4

  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    # 現在位置から到達できる駅を調べる
    current_nearest_station = Station.near(@current_coordinates, 10, unit: :km).first
    home_nearest_station = Station.near(@home_coordinates, 10, unit: :km).first

    # 最も値段が安いホテルをレコメンドするホテルとする
    cheapest_hotel = Hotel.hotel.includes(:station).where(stations: { code: current_nearest_station.code }).order(:price).first
    
    # ホテルからの最寄駅 => 自宅までのルートを計算
    train_route_to_nearest_home = TrainRouteClient.request(station_code_from: current_nearest_station.code, station_code_to: home_nearest_station.code, is_next_day: true)

    # Planを返す
    line_to_nearest_home = train_route_to_nearest_home.first[:lines].first

    # 現在地 => ホテル(渋谷東武ホテル)
    minute1 = TimeCalculator.travel_minute(@current_coordinates, cheapest_hotel, WALK_SPEED)
    next_action1 = NextAction.new(method: 'walk', required_minute: minute1, physical_point: 10)
    detail1 = Detail.new(place_genre: 'other', name: '現在地', arrive_at: nil, leave_at: nil, next_action: next_action1)
    
    # ホテル(渋谷東武ホテル) => ホテルの最寄駅(品川)
    next_action2 = NextAction.new(method: 'walk', required_minute: minute1, physical_point: 10)
    detail2 = Detail.new(place_genre: 'hotel', name: cheapest_hotel.name, price: cheapest_hotel.price, arrive_at: nil, leave_at: line_to_nearest_home[:leave_at] - minute1.minute, next_action: next_action2)

    # ホテルの最寄駅(品川) => 自宅の最寄駅(保土ヶ谷駅)
    train = Train.new(line: line_to_nearest_home[:name], direction: line_to_nearest_home[:direction], track: line_to_nearest_home[:track])
    next_action3 = NextAction.new(method: 'train', price: line_to_nearest_home[:price], required_minute: (line_to_nearest_home[:arrive_at] - line_to_nearest_home[:leave_at]) / 60, physical_point: 200, train: train)
    detail3 = Detail.new(place_genre: 'station', name: line_to_nearest_home[:from][:station_name], arrive_at: line_to_nearest_home[:leave_at], leave_at: line_to_nearest_home[:leave_at], next_action: next_action3)

    # 自宅の最寄駅(保土ヶ谷駅) => 自宅
    minute4 = TimeCalculator.travel_minute(home_nearest_station, @home_coordinates, WALK_SPEED)
    next_action4 = NextAction.new(method: 'walk', required_minute: minute4)
    detail4 = Detail.new(place_genre: 'station', name: line_to_nearest_home[:to][:station_name], arrive_at: line_to_nearest_home[:arrive_at], leave_at: line_to_nearest_home[:arrive_at], next_action: next_action4)

    # 自宅
    detail5 = Detail.new(place_genre: 'other', name: '自宅', arrive_at: line_to_nearest_home[:arrive_at] + minute4.minute, leave_at: nil)

    Plan.new(
      details: [detail1, detail2, detail3, detail4, detail5],
      description: "#{cheapest_hotel.station.name}付近で宿泊"
    )
  end
end
