require_relative 'store_item'

class Book < StoreItem
  attr_accessor :author_name, :number_of_pages, :isbn

  def initialize(title, price, author_name, number_of_pages, isbn)
    super(title, price)
    @author_name = author_name
    @number_of_pages = number_of_pages
    @isbn = isbn
  end

  def to_s
    "title=#{@title}, price=#{@price}, author_name=#{@author_name}, number_of_pages=#{@number_of_pages}, isbn=#{@isbn}"
  end

  def to_item
    [@title, @price, "AuthorName: #{@author_name}, NumberOfPages: #{@number_of_pages}, ISBN: #{@isbn}"]
  end
end
