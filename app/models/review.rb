class Review < ApplicationRecord
  validates :content_title, {presence: true}
  validates :content, {presence: true}
  validates :book_id, {presence: true}
  validates :user_id, {presence: true}
  
  belongs_to :book
  belongs_to :user
end

