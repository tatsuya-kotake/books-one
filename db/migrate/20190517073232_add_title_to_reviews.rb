class AddTitleToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :content_title, :string
  end
end
