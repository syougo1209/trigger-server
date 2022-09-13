class Detail
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string, default: ''
  attribute :arrived_at, :datetime
  attribute :leaved_at, :datetime
  attribute :price, :integer, default: 0
  attribute :next_action
end
