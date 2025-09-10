# spec/system/books_spec.rb
require "rails_helper"

RSpec.describe "Books", type: :system do
  it "creates a book successfully and shows flash notice" do
    visit books_path
    click_on "Add New Book"

    fill_in "Title", with: "Dune"
    fill_in "Author", with: "Frank Herbert"
    fill_in "Price", with: "19.99"
    fill_in "Published date", with: "1965-08-01"

    click_on "Create Book"

    expect(page).to have_text("Book successfully added.")
    expect(page).to have_link("Dune", href: book_path(Book.last))
  end

  it "fails to create when author is blank and shows validation/alert" do
    visit books_path
    click_on "Add New Book"

    fill_in "Title", with: "Dune"
    fill_in "Author", with: ""
    fill_in "Price", with: "19.99"
    fill_in "Published date", with: "1965-08-01"

    click_on "Create Book"

    expect(page).to have_css("#error_explanation")
    expect(page).to have_text("Author can't be blank")
  end

  it "fails to create when price is blank" do
    visit books_path
    click_on "Add New Book"

    fill_in "Title", with: "Dune"
    fill_in "Author", with: "Frank Herbert"
    fill_in "Price", with: ""
    fill_in "Published date", with: "1965-08-01"

    click_on "Create Book"

    expect(page).to have_css("#error_explanation")
    expect(page).to have_text("Price can't be blank")
  end

  it "fails to create when price is negative" do
    visit books_path
    click_on "Add New Book"

    fill_in "Title", with: "Dune"
    fill_in "Author", with: "Frank Herbert"
    fill_in "Price", with: "-1"
    fill_in "Published date", with: "1965-08-01"

    click_on "Create Book"

    expect(page).to have_css("#error_explanation")
    expect(page).to have_text("Price must be greater than or equal to 0")
  end

  it "fails to create when published date is blank" do
    visit books_path
    click_on "Add New Book"

    fill_in "Title", with: "Dune"
    fill_in "Author", with: "Frank Herbert"
    fill_in "Price", with: "19.99"
    fill_in "Published date", with: ""

    click_on "Create Book"

    expect(page).to have_css("#error_explanation")
    expect(page).to have_text("Published date can't be blank")
  end
end