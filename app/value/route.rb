class Route
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :from, :string
  attribute :to, :string
  attribute :leave_at, :datetime
  attribute :arrive_at, :datetime
  attribute :required_minute, :integer
  attribute :price, :integer
  attribute :method, :string
end
