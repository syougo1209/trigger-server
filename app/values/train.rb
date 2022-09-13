class Train
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :line, :string, default: ''
  attribute :direction, :string, default: ''
  attribute :track, :string, default: ''
end
