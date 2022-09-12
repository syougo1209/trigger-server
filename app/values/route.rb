class Route
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :arrived_at, :datetime
  attribute :leaved_at, :datetime
  attribute :price, :integer
  attr_reader :next_action

  def initialize(attributes = nil, next_action: NextAction.new)
    @next_action = next_action
    super(attributes)
  end
end
