class CreateFullTrainPlanService
  WALK_SPEED = 4
  
  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    current_nearest_station = Station.near(@current_coordinates, 10, unit: :km).first
    home_nearest_station = Station.near(@home_coordinates, 10, unit: :km).first

    train_route = TrainRouteClient.request(station_code_from: current_nearest_station.code, station_code_to: home_nearest_station.code)

    lines = train_route.last[:lines]
    first_line = lines.first

    details = []

    # 現在地 => 現在地からの最寄駅(渋谷)
    details << to_current_nearest_station(current_nearest_station: current_nearest_station, line: first_line)[:detail]

    # 現在地からの最寄駅(渋谷) => 自宅の最寄駅(保土ヶ谷駅)
    to_home_nearest_station = to_home_nearest_station_details(lines: lines)
    details.concat(to_home_nearest_station[:details])
    last_line = to_home_nearest_station[:last_line]

    # 自宅の最寄駅(保土ヶ谷駅) => 自宅
    to_home = to_home(home_nearest_station: home_nearest_station, line: last_line)
    details << to_home[:detail]
    walk_min_to_home = to_home[:walk_min_to_home]

    # 自宅
    details << arrived_home(line: last_line, walk_min_to_home: walk_min_to_home)[:detail]

    Plan.new(
      details: details,
      description: '終電で帰宅'
    )
  end

  private

  def to_current_nearest_station(current_nearest_station:, line:)
    minute = TimeCalculator.travel_minute(@current_coordinates, current_nearest_station, WALK_SPEED)
    next_action = NextAction.new(method: 'walk', required_minute: minute)
    detail = Detail.new(place_genre: 'other', name: '現在地', next_action: next_action, arrive_at: nil, leave_at: line[:leave_at] - minute.minutes)
    { detail: detail }
  end

  def to_home_nearest_station_details(lines:)
    last_arrive_at = lines.first[:leave_at]
    details = lines.map do |line|
      train = Train.new(line: line[:name], direction: line[:direction], track: line[:track])
      next_action = NextAction.new(method: 'train', price: line[:price], required_minute: (line[:arrive_at] - line[:leave_at]) / 60, train: train)
      detail = Detail.new(place_genre: 'station', name: line[:from][:station_name], arrive_at: last_arrive_at, leave_at: line[:leave_at], next_action: next_action)
      last_arrive_at = line[:arrive_at]
      detail
    end
    { details: details, last_line: lines.last }
  end

  def to_home(home_nearest_station:, line:)
    walk_min_to_home = TimeCalculator.travel_minute(home_nearest_station, @home_coordinates, WALK_SPEED)
    next_action = NextAction.new(method: 'walk', required_minute: walk_min_to_home)
    detail = Detail.new(place_genre: 'station', name: line[:to][:station_name], arrive_at: line[:arrive_at], leave_at: line[:arrive_at], next_action: next_action)
    { detail: detail, walk_min_to_home: walk_min_to_home }
  end

  def arrived_home(line:, walk_min_to_home:)
    detail = Detail.new(place_genre: 'other', name: '自宅', arrive_at: line[:arrive_at] + walk_min_to_home, leave_at: nil)
    { detail: detail }
  end
end
