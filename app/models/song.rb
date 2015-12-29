class Song < ActiveRecord::Base
  has_and_belongs_to_many :artists
  validate :has_at_least_one_artist
  validates :title, uniqueness: { scope: :artists,
    message: "Song already exists" }

  private
  def has_at_least_one_artist
    errors.add(:artists, 'Requires at least one artist') if artists.empty?
  end
end
