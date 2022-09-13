class Plan
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :time_limit, :string
  attribute :is_use_train, :boolean
  attribute :is_use_taxi, :boolean
  attribute :is_use_hotel, :boolean
  attribute :physical_point, :integer
  attribute :details

  def initialize(time_limit: "",routes:)
    @time_limit = time_limit
    @details = routes
    @is_use_taxi = routes.any? {|v| v.next_action.use_taxi?}
    @is_use_hotel = routes.any? {|v| v.next_action.use_hotel?}
    @is_use_train = routes.any? {|v| v.next_action.use_train?}
    @price = routes.map(&:total_price_of_next_action_and_route).inject { |sum, i| sum + i }
    @physical_point = routes.map {|v| v.next_action.physical_point}.inject { |sum, i| sum + i }
  end
end
