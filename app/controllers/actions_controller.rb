class ActionsController < ApplicationController
  def index
    current_coordinates = [35.666015, 139.698228] # 渋谷区
    home_coordinates = [35.465967, 139.570486] # 保土ヶ谷

    full_train_plan = CreateFullTrainPlanService.new(current_coordinates: current_coordinates, home_coordinates: home_coordinates).call
    full_taxi_plan = CreateFullTaxiPlanService.new(current_coordinates: current_coordinates, home_coordinates: home_coordinates).call
    train_hotel = CreateTrainHotelService.new(current_coordinates: current_coordinates, home_coordinates: home_coordinates).call

    @plans = [full_train_plan, full_taxi_plan, train_hotel]
  end
end
