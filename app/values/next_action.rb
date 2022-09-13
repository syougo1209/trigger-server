class NextAction
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :method, :string, default: ''
  attribute :price, :integer, default: 0
  attribute :required_minute, :integer, default: 0
  attribute :physical_point, :integer, default: 0
  attribute :train
end
