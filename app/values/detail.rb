class Detail
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :place_genre, :string, default: ''
  attribute :name, :string, default: ''
  attribute :arrive_at, :datetime
  attribute :leave_at, :datetime
  attribute :price, :integer, default: 0
  attribute :next_action

  def total_price_of_next_action_and_route
    price + next_action.price
  end

  def use_hotel?
    place_genre == 'hotel'
  end
end
