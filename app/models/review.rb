class Review < ApplicationRecord
  has_many :comments

  belongs_to :user
  belongs_to :anime

  validates :user, presence: true
  validates :title, presence: true
  validates :content, presence: true
end
