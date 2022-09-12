class TaxiCostCalculator
  def self.calc_cost(point1, point2)
    kilometer = point1.distance_to(point2)
    meter = kilometer * 1000

    420 + ((meter - 1052) / 233).to_i * 80
  end
end

# 初乗運賃：1052mまで420円
# 加算運賃：以後233mごとに80円
