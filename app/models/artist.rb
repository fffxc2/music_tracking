class Artist < ActiveRecord::Base
  has_many :artists_songs
  has_many :songs, through: :artists_songs

  validates :name, presence: true, allow_blank: false
  validates_uniqueness_of :name
  validates :author_id, presence: true, inclusion: { in: User.all.map(&:id) }

  scope :named, ->(name) { where("lower(name) LIKE lower(?)", "%#{name}%") }
end
