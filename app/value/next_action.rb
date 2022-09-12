class NextAction
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :method, :string
  attribute :price, :integer
  attribute :required_minute, :integer
  attribute :train
end
