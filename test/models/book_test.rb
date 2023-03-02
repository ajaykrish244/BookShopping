require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "has valid inputs" do
    book = Book.new(:name => "some book",
                    :author => "author",
                    :publisher => "publihser",
                    :price => 5.0,
                    :quantity => 100)
    assert_equal(book.name, 'some book')
    assert_equal(book.author,'author')
    assert_equal(book.publisher,'publihser')
    assert_operator book.quantity, :>=, 0
    assert_operator book.price, :>=, 0
  end


end
