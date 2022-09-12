class CreateLastTrainPlanService
  attr_reader :current_coordinates
  attr_reader :home_coordinates

  def call
    walk_route = create_walk_route
  end

  private

  def create_walk_route
    TimeCalculator.travel_minute(current_coordinates, )
  end

  def mock
    {time_limit: '2022-09-09T23:38:00Z'}
  end
end
