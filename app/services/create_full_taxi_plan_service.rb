class CreateFullTaxiPlanService
  attr_reader :current_coordinates
  attr_reader :home_coordinates

  def call
    @cost = TaxiCostCalculator.calc_cost(@current_coordinates, @home_coordinates)
    @minute = TimeCalculator.travel_minute(@current_coordinates, @home_coordinates, 40)

    route1 = create_full_taxi_route
    route2 = create_home_route

    result = create_result([route1,route2])
  end

  private

  def create_full_taxi_route
    train = Train.new
    next_action = NextAction.new( method: 'taxi', price: @cost, required_minute: @minute , train: train, physical_point: 100)

    Route.new(name: '現在地', price: 0 , next_action: next_action)
  end

  def create_home_route
    train = Train.new
    next_action = NextAction.new( method: '', price: 0, required_minute: 0, train: train, physical_point: 0)

    Route.new(name: '自宅', price: 0 , next_action: next_action)
  end

  def create_result(routes)
    hash = {time_limit: "", details: routes}
    hash[:is_use_train] = routes.any? {|v| v.next_action.use_train?}
    hash[:is_use_taxi] = routes.any? {|v| v.next_action.use_taxi?}
    hash[:is_use_hotel] = routes.any? {|v| v.next_action.use_hotel?}
    hash[:price] = routes.map(&:total_price_of_next_action_and_route).inject { |sum, i| sum + i }
    hash[:physical_point] = routes.map {|v| v.next_action.phyisical_point}.inject { |sum, i| sum + i }
  end
end
