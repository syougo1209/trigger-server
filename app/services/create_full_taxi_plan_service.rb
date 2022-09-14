class CreateFullTaxiPlanService
  def initialize(current_coordinates:, home_coordinates:)
    @current_coordinates = current_coordinates
    @home_coordinates = home_coordinates
  end

  def call
    detail1 = create_full_taxi_route
    detail2 = create_home_route

    Plan.new(
      details: [detail1, detail2],
      description: '自宅までタクシー'
    )
  end

  private

  def create_full_taxi_route
    cost = TaxiCostCalculator.calc_cost(@current_coordinates, @home_coordinates)
    minute = TimeCalculator.travel_minute(@current_coordinates, @home_coordinates, 40)
    next_action = NextAction.new(method: 'taxi', price: cost, required_minute: minute , physical_point: 100)

    Detail.new(place_genre: 'other', name: '現在地', next_action: next_action)
  end

  def create_home_route
    Detail.new(place_genre: 'other', name: '自宅')
  end
end
