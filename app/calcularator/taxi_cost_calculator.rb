class TaxiCostCalculator
  def self.calc_cost(coordinates1, coordinates2)
    kilometer = Geocoder::Calculations.distance_between(coordinates1, coordinates2)
    meter = kilometer * 1000

    420 + ((meter - 1052) / 233).to_i * 80
  end
end

# 初乗運賃：1052mまで420円
# 加算運賃：以後233mごとに80円
