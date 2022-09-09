class Hotel < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :genre, presence: true

  enum genre: { hotel: 0, manga_cafe: 1 }

  belongs_to :station
end
