class Anime < ApplicationRecord
  has_many :reviews
  has_many :anime_genres
  has_many :genres, through: :anime_genres

  validates :name, presence: true
  validates :introdution, presence: true
  validates :web_ratting, presence: true
  validates :image, presence: true
  do_not_validate_attachment_file_type :image

  ratyrate_rateable "story", "art", "sound", "character", "enjoyment"

  has_attached_file :image,
    styles: {small: "50x50", med: "100x100", large: "300x300"}

  def overall_ratings
    array = Rate.where rateable_id: id, rateable_type: "Anime"
    stars = array.map {|this| this.stars}
    star_count = stars.count
    stars_total = stars.inject(0) {|sum,x| sum + x}
    score = stars_total / (star_count.nonzero? || 1)
  end
end
