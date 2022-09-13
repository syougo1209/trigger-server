class Plan
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :time_limit, :datetime
  attribute :price, :integer, default: 0
  attribute :all_point, :integer, default: 0
  attribute :physical_point, :integer, default: 0
  attribute :is_use_train, :boolean, default: false
  attribute :is_use_taxi, :boolean, default: false
  attribute :is_use_hotel, :boolean, default: false
  attribute :details_length, :integer, default: 0
  attribute :details, default: []

  def initialize(details:)
    super()
    @time_limit = details.first.leaved_at
    @physical_point = details.inject(0) { |sum, detail| sum + detail.next_action.physical_point }
    @price = details.inject(0) { |sum, detail| sum + detail.price + detail.next_action.price }
    @is_use_train = details.any? {|detail| detail.next_action.method == 'train'}
    @is_use_taxi = details.any? {|detail| detail.next_action.method == 'taxi'}
    @is_use_hotel = details.any? {|detail| detail.next_action.method == 'hotel'}
    @details_length = details.size
    @details = details
  end
end
