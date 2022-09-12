class CreateFullTaxiPlanService
  def self.call(current_coordinates, home_coordinates)
    cost = TaxiCostCalculator.calc_cost(current_coordinates, home_coordinates)
    minute = TimeCalculator.travel_minute(current_coordinates, home_coordinates, 40)
    puts("#{cost}円 #{minute}分")
  end
end
