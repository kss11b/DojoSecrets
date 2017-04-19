class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :ideas
  has_many :likes, dependent: :destroy
  has_many :ideas_liked, through: :likes, source: :idea
  validates :name, presence: true, length: {minimum: 2}
  validates :alias, presence: true, length: {minimum: 2}
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
end
