class CreateFullTaxiPlanService
  ##中目黒 35.643349, 139.694643
  ## 大久保 35.699840, 139.699339

  def initialize(current_coordinates:,home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    @cost = TaxiCostCalculator.calc_cost(@current_coordinates, @home_coordinates)
    @minute = TimeCalculator.travel_minute(@current_coordinates, @home_coordinates, 40)

    route1 = create_full_taxi_route
    arrived_at_home = Time.current + (@minute *60)

    route2 = create_home_route(arrived_at_home)

    result = create_result([route1,route2])

    Plan.new(routes: [route1, route2])
  end

  private

  def create_full_taxi_route
    train = Train.new
    next_action = NextAction.new( method: 'taxi', price: @cost, required_minute: @minute , train: train, physical_point: 100)

    Route.new(name: '現在地', price: 0 , next_action: next_action, arrived_at: nil, leaved_at: nil)
  end

  def create_home_route(arrived_at_home)
    train = Train.new
    next_action = NextAction.new(method: '', price: 0, required_minute: 0, train: train, physical_point: 0)

    Route.new(name: '自宅', price: 0 , next_action: next_action, arrived_at: arrived_at_home, leaved_at: nil)
  end
end
