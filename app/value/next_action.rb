class NextAction
  include ActiveModel::Model
  include ActiveModel::Attributes

  # todo methodをenumにする
  attribute :method, :string
  attribute :price, :integer
  attribute :required_minute, :integer
  attribute :phyisical_point, :integer
  attribute :train

  def use_taxi?
    method == 'taxi'
  end

  def use_train?
    method == 'train'
  end

  def use_hotel?
    method == 'hotel'
  end
end
