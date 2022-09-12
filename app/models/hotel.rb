class Hotel < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :postcode, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :genre, presence: true
  belongs_to :station

  enum genre: { hotel: 0, manga_cafe: 1 }

  geocoded_by :postcode
  before_validation :geocode
end
