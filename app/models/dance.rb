class Dance < ActiveRecord::Base
  has_many :dances_songs
  has_many :songs, through: :dances_songs

  validates :name, presence: true, allow_blank: false

  scope :named, ->(name) { where("lower(name) LIKE lower(?)", "%#{name}%") }
end
