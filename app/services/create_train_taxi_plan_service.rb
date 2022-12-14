class CreateTrainTaxiPlanService
  WALK_SPEED = 4

  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end
  
  def call
    # 現在位置から到達できる駅を調べる
    current_nearest_station = Station.near(@current_coordinates, 10, unit: :km).first
    home_nearest_station = Station.near(@home_coordinates, 10, unit: :km).first

    train_route = TrainRouteClient.request(station_code_from: current_nearest_station.code, station_code_to: 'shinagawa')

    # Planを返す
    line = train_route.first[:lines].first

    # 現在地 => 現在地からの最寄駅(渋谷)
    minute1 = TimeCalculator.travel_minute(@current_coordinates, current_nearest_station, WALK_SPEED)
    next_action1 = NextAction.new(method: 'walk', required_minute: minute1)
    detail1 = Detail.new(place_genre: 'other', name: '現在地', next_action: next_action1, arrive_at: nil, leave_at: line[:leave_at] - minute1.minutes)

    # 現在地からの最寄駅(渋谷) => タクシーの乗車駅(品川)
    train2 = Train.new(line: line[:name], direction: line[:direction], track: line[:track])
    next_action2 = NextAction.new(method: 'train', price: line[:price], required_minute: (line[:arrive_at] - line[:leave_at]) / 60, train: train2)
    detail2 = Detail.new(place_genre: 'station', name: line[:from][:station_name], arrive_at: line[:leave_at], leave_at: line[:leave_at], next_action: next_action2)

    # タクシーの乗車駅(品川) => 自宅
    transfer_station = Station.find_by(code: line[:to][:station_code])
    cost = TaxiCostCalculator.calc_cost(transfer_station, @home_coordinates)
    minute3 = TimeCalculator.travel_minute(transfer_station, @home_coordinates, 40)
    next_action3 = NextAction.new(method: 'taxi', price: cost, required_minute: minute3 , physical_point: 100)
    detail3 = Detail.new(place_genre: 'station', name: line[:to][:station_name], arrive_at: line[:arrive_at], leave_at: line[:arrive_at], next_action: next_action3)

    # 自宅
    detail4 = Detail.new(place_genre: 'other', name: '自宅', arrive_at: line[:arrive_at] + minute3.minute, leave_at: nil)

    Plan.new(
      details: [detail1, detail2, detail3, detail4],
      description: "#{line[:to][:station_name]}からタクシー"
    )
  end
end
