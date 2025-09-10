class Book < ApplicationRecord
  validates :title, :author, :published_date, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0 }
end