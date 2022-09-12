class NextAction
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :method, :string
  attribute :price, :integer
  attribute :required_minute, :integer
  attr_reader :train

  def initialize(attributes = nil, train: Train.new)
    @train = train
    super(attributes)
  end
end
