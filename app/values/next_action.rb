class NextAction
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :method, :string, default: ''
  attribute :price, :integer, default: 0
  attribute :required_minute, :integer, default: 0
  attribute :physical_point, :integer, default: 0
  attribute :train, default: Train.new

  def initialize(attributes={})
    super(attributes)
    self.physical_point = calc_physical_point
  end

  def use_taxi?
    method == 'taxi'
  end

  def use_train?
    method == 'train'
  end

  def to_walk?
    method == 'walk'
  end

  private

  def calc_physical_point
    if use_taxi?
      required_minute / 10  # タクシー10分あたり1ポイント
    elsif use_train?
      required_minute / 5  # 電車5分あたり1ポイント
    elsif to_walk?
      required_minute / 2  # 歩き2分あたり1ポイント
    else
      0
    end
  end
end
