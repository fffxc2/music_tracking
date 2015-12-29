class Artist < ActiveRecord::Base
  has_many :artists_songs
  has_many :songs, through: :artists_songs

  validates_uniqueness_of :name

  scope :named, ->(name) { where("lower(name) LIKE lower(?)", "%#{name}%") }
end
