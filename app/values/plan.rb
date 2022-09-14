class Plan
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :time_limit
  attr_reader :price
  attr_reader :all_point
  attr_reader :physical_point
  attr_reader :is_use_train
  attr_reader :is_use_taxi
  attr_reader :is_use_hotel
  attr_reader :details_length

  attribute :details, default: []

  def initialize(attributes={})
    super(attributes)
    @time_limit = attributes[:details].first.leave_at
    @physical_point = attributes[:details].inject(0) { |sum, detail| sum + detail.physical_point }
    @price = attributes[:details].inject(0) { |sum, detail| sum + detail.total_price_of_next_action_and_route }
    @is_use_train = attributes[:details].any? {|detail| detail.next_action.use_train?}
    @is_use_taxi = attributes[:details].any? {|detail| detail.next_action.use_taxi?}
    @is_use_hotel = attributes[:details].any? {|detail| detail.use_hotel?}
    @details_length = attributes[:details].size
  end
end
