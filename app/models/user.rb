class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :name, :address, :city, :state, :zip
  validates_presence_of  :password_digest, require: true
  has_many :orders
  has_many :merchant_users
  has_many :merchants, through: :merchant_users

  enum role: %w(default merchant admin)
end
