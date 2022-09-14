class Detail
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :place_genre, :string, default: ''
  attribute :name, :string, default: ''
  attribute :arrive_at, :datetime
  attribute :leave_at, :datetime
  attribute :price, :integer, default: 0
  attribute :physical_point, :integer, default: 0
  attribute :next_action, default: NextAction.new

  def initialize(attributes={})
    super(attributes)
    puts next_action.attributes
    self.physical_point = calc_physical_point + (next_action.physical_point || 0)
  end

  def total_price_of_next_action_and_route
    price + next_action.price
  end

  def use_hotel?
    place_genre == 'hotel'
  end

  private

  def calc_physical_point
    if use_hotel?
      hotel = Hotel.find_by(name: name)
      case hotel.genre
      when :hotel
        3
      when :manga_cafe
        15
      else
        0
      end
    else
      0
    end
  end
end
