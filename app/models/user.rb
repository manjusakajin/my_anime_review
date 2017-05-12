class User < ApplicationRecord
  has_many :reviews
  has_many :comments
  has_many :rates

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password
end
