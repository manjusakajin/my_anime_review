class Anime < ApplicationRecord
  has_many :reviews
  has_many :anime_genres
  has_many :genres, through: :anime_genres
  has_many :rates
end
