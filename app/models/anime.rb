class Anime < ApplicationRecord
  has_many :reviews
  has_many :anime_genres
  has_many :genres, through: :anime_genres
  has_many :rates

  validates :name, presence: true
  validates :introdution, presence: true
  validates :web_ratting, presence: true

end
