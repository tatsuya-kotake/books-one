class Book < ApplicationRecord
  validates :title, {presence: true}
  validates :user_id, {presence: true}

  has_many :reviews
  belongs_to :user
  
  def reviewed_id
    @review = Review.find_by(book_id: self.id)
    if @review
      return @review.id
    end
  end  
end
