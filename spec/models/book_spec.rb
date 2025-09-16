# spec/models/book_spec.rb
require "rails_helper"

RSpec.describe Book, type: :model do
  context "validations" do
    it "is valid with title, author, price, and published_date" do
      book = Book.new(
        title: "Dune",
        author: "Frank Herbert",
        price: 19.99,
        published_date: Date.new(1965, 8, 1)
      )
      expect(book).to be_valid
    end

    it "is invalid without author" do
      book = Book.new(title: "Dune", price: 19.99, published_date: Date.new(1965,8,1))
      expect(book).not_to be_valid
      expect(book.errors[:author]).to include("can't be blank")
    end

    it "is invalid without price" do
      book = Book.new(title: "Dune", author: "Frank Herbert", published_date: Date.new(1965,8,1))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("can't be blank")
    end

    it "is invalid with negative price" do
      book = Book.new(title: "Dune", author: "Frank Herbert", price: -1, published_date: Date.new(1965,8,1))
      expect(book).not_to be_valid
      expect(book.errors[:price]).to include("must be greater than or equal to 0")
    end

    it "is invalid without published_date" do
      book = Book.new(title: "Dune", author: "Frank Herbert", price: 19.99)
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end

    it "is invalid with a non-parsable published_date" do
      book = Book.new(title: "Dune", author: "Frank Herbert", price: 19.99, published_date: "not-a-date")
      # When the column exists as :date, Rails type-casts invalid strings to nil.
      expect(book).not_to be_valid
      expect(book.errors[:published_date]).to include("can't be blank")
    end
  end
end