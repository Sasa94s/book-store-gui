require_relative 'list_view'

class ListBooksWithRangeView
  @@title = 'List Books with Range'
  attr_accessor :f, :from_price, :to_price, :submit

  def initialize
    @f = Flammarion::Engraving.new(title: @@title, close_on_exit: true)
    @f.markdown("<center><h1>#{@@title}</h1></center>")
    @f.input('From Price') { |msg| @from_price = msg['text'] }
    @f.input('To Price') { |msg| @to_price = msg['text'] }
    @f.button('Submit') { submit }
    @f.wait_until_closed
  end

  def submit
    ListView.new(
      @@title,
      %w[Title Price AuthorName NumberOfPages ISBN],
      $store_items.filter { |item| item.is_a? Book }
                  .filter { |item| item.price >= @from_price.to_i && item.price <= @to_price.to_i }
                  .map do |item|
                    [item.title, item.price, item.author_name, item.number_of_pages, item.isbn]
                  end
    )
  end
end
