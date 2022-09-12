class PlannedPlace
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :leaved_at, :datetime
  attribute :arrived_at, :datetime
  attribute :price, :integer

  attr_reader :next_action

  def initialize(attributes={})
    @next_action = NextAction.new(attributes)
    super(attributes)
  end
end
