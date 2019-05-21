class Review < ApplicationRecord
  validates :content_title, {presence: true}
  validates :content, {presence: true}
  
  
  belongs_to :book
  
end

