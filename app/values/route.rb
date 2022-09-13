class Route
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :arrived_at, :datetime
  attribute :leaved_at, :datetime
  attribute :price, :integer
  attribute :next_action

  def total_price_of_next_action_and_route
    price + next_action.price
  end
end
