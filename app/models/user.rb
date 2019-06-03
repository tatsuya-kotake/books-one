class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true}
  validates :password, {presence: true}
  
  has_secure_password
  
  has_many :books
  has_many :reviews
end