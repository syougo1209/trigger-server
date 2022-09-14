class CreateTrainHotelService
  include TrainRouteUtil

  WALK_SPEED = 4
  
  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end
  
  def call
    # 現在位置から到達できる駅を調べる
    current_nearest_station = Station.near(@current_coordinates, 10, unit: :km).first
    home_nearest_station = Station.near(@home_coordinates, 10, unit: :km).first

    # 到達できるまでの駅の、一覧を取得する
    # TODO: station_code_to を home_nearest_station の途中から取る
    train_route = TrainRouteClient.request(station_code_from: current_nearest_station.code, station_code_to: 'shinagawa')
    stop_stations_code = TrainRouteUtil.stop_stations_code(train_route)
    stop_stations_code << train_route.first[:to][:station_code]

    # 駅一覧の、それぞれの近くの宿泊施設一覧を取得する & 最も値段が安いホテルをレコメンドするホテルとする
    cheapest_hotel = Hotel.hotel.includes(:station).where(stations: { code: stop_stations_code }).order(:price).first

    # ホテルからの最寄駅 => 自宅までのルートを計算
    train_route_to_nearest_home = TrainRouteClient.request(station_code_from: cheapest_hotel.station.code, station_code_to: home_nearest_station.code, is_next_day: true)

    # Planを返す
    line = train_route.first[:lines].first

    # 現在地 => 現在地からの最寄駅(渋谷)
    minute1 = TimeCalculator.travel_minute(@current_coordinates, current_nearest_station, WALK_SPEED)
    next_action1 = NextAction.new(method: 'walk', required_minute: minute1)
    detail1 = Detail.new(place_genre: 'other', name: '現在地', next_action: next_action1, arrive_at: nil, leave_at: line[:leave_at] - minute1.minutes)

    # 現在地からの最寄駅(渋谷) => ホテルの最寄駅(品川)
    train2 = Train.new(line: line[:name], direction: line[:direction], track: line[:track])
    next_action2 = NextAction.new(method: 'train', price: line[:price], required_minute: (line[:arrive_at] - line[:leave_at]) / 60, train: train2)
    detail2 = Detail.new(place_genre: 'station', name: line[:from][:station_name], arrive_at: line[:leave_at], leave_at: line[:leave_at], next_action: next_action2)

    # ホテルの最寄駅(品川) => ホテル(品川東武ホテル)
    station_coordinates = Geocoder.search(line[:to][:station_name]).first.coordinates
    minute3 = TimeCalculator.travel_minute(station_coordinates, cheapest_hotel, WALK_SPEED)
    next_action3 = NextAction.new(method: 'walk', required_minute: minute3)
    detail3 = Detail.new(place_genre: 'station', name: line[:to][:station_name], arrive_at: line[:arrive_at], leave_at: line[:arrive_at], next_action: next_action3)

    # ホテル(品川東武ホテル) => ホテルの最寄駅(品川)
    line_to_nearest_home = train_route_to_nearest_home.first[:lines].first

    next_action4 = NextAction.new(method: 'walk', required_minute: minute3)
    detail4 = Detail.new(place_genre: 'hotel', name: cheapest_hotel.name, arrive_at: line[:arrive_at] + minute3.minutes, leave_at: line_to_nearest_home[:leave_at] - minute3.minutes, price: cheapest_hotel.price, next_action: next_action4)

    # ホテルの最寄駅(品川) => 自宅の最寄駅(保土ヶ谷駅)
    train5 = Train.new(line: line_to_nearest_home[:name], direction: line_to_nearest_home[:direction], track: line_to_nearest_home[:track])
    next_action5 = NextAction.new(method: 'train', price: line_to_nearest_home[:price], required_minute: (line[:arrive_at] - line[:leave_at]) / 60, train: train5)
    detail5 = Detail.new(place_genre: 'station', name: line_to_nearest_home[:from][:station_name], arrive_at: line_to_nearest_home[:leave_at], leave_at: line_to_nearest_home[:leave_at], next_action: next_action5)

    # 自宅の最寄駅(保土ヶ谷駅) => 自宅
    minute6 = TimeCalculator.travel_minute(home_nearest_station, @home_coordinates, WALK_SPEED)
    next_action6 = NextAction.new(method: 'walk', required_minute: minute6)
    detail6 = Detail.new(place_genre: 'station', name: line_to_nearest_home[:to][:station_name], arrive_at: line_to_nearest_home[:arrive_at], leave_at: line_to_nearest_home[:arrive_at], next_action: next_action6)

    # 自宅
    detail7 = Detail.new(place_genre: 'other', name: '自宅', arrive_at: line_to_nearest_home[:arrive_at] + minute6.minute, leave_at: nil)

    Plan.new(details: [detail1, detail2, detail3, detail4, detail5, detail6, detail7])
  end
end
