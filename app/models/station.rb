class Station < ApplicationRecord
  validates :code, presence: true, length: { maximum: 100 }
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  has_many :hotels, dependent: :delete_all

  geocoded_by :name
  before_validation :geocode
end
