class CreateFullTaxiPlanService
  # 中目黒 35.643349, 139.694643
  # 大久保 35.699840, 139.699339

  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    detail1 = create_full_taxi_route
    detail2 = create_home_route

    Plan.new(details: [detail1, detail2])
  end

  private

  def create_full_taxi_route
    train = Train.new
    cost = TaxiCostCalculator.calc_cost(@current_coordinates, @home_coordinates)
    @minute = TimeCalculator.travel_minute(@current_coordinates, @home_coordinates, 40)
    next_action = NextAction.new(method: 'taxi', price: cost, required_minute: @minute , physical_point: 100, train: train)

    Detail.new(name: '現在地', next_action: next_action, leaved_at: Time.current, arrived_at: nil)
  end

  def create_home_route
    train = Train.new
    next_action = NextAction.new(train: train)
    arrived_at = Time.current + @minute * 60
    Detail.new(name: '自宅', next_action: next_action, leaved_at: nil, arrived_at: arrived_at )
  end
end
