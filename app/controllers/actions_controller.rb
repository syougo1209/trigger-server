class ActionsController < ApplicationController
  # 渋谷区 35.666015, 139.698228
  # 保土ヶ谷 35.465967, 139.570486
  def index
    @full_taxi_plan = CreateFullTaxiPlanService.new(current_coordinates: [35.666015, 139.698228], home_coordinates: [35.465967, 139.570486]).call
    @hotel_to_home_plan = CreateHotelToHomePlanService.new(current_coordinates: [35.666015, 139.698228], home_coordinates: [35.465967, 139.570486]).call
  end
end
