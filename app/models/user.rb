class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email

  has_many :reviews
  has_many :comments
  has_many :rates

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 6, maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum:6}, allow_blank: true

  has_secure_password

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attributes remember_digest: nil
  end

  private

  def downcase_email
    email.downcase!
  end
end