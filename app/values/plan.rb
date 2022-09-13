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

    super(attributes)
    @time_limit = attributes[:details].first.leaved_at
    @physical_point = attributes[:details].inject(0) { |sum, detail| sum + detail.next_action.physical_point }
    @price = attributes[:details].map(&:total_price_of_next_action_and_route).inject { |sum, i| sum + i }
    @is_use_train = attributes[:details].any? {|detail| detail.next_action.use_train?}
    @is_use_taxi = attributes[:details].any? {|detail| detail.next_action.use_taxi?}
    @is_use_hotel = attributes[:details].any? {|detail| detail.next_action.use_hotel?}
    @details_length = attributes[:details].size
  end
