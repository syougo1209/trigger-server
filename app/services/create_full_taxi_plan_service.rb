class CreateFullTaxiPlanService
  def self.call(current_coordinates, home_coordinates)
    cost = TaxiCostCalculator.calc_cost(current_coordinates, home_coordinates)
    minute = TimeCalculator.travel_minute(current_coordinates, home_coordinates, 40)

    train = Train.new
    next_action = NextAction.new({ method: 'タクシー', price: cost, required_minute: minute }, train: train)

    Route.new({ name: '現在地', price: 0 }, next_action: next_action)
  end
end
