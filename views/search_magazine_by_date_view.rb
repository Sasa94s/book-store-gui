class SearchMagazineByDateView
  @@title = 'Search Magazine by Date'
  attr_accessor :f, :date

  def initialize
    @f = Flammarion::Engraving.new(title: @@title, close_on_exit: true)
    @f.markdown("<center><h1>#{@@title}</h1></center>")
    @f.input('Date') { |msg| @date = msg['text'] }
    @f.button('Submit') { submit }
    @f.wait_until_closed
  end

  def submit
    ListView.new(
      @@title,
      %w[Title Price PublisherAgent Date],
      $store_items.filter { |item| item.is_a? Magazine }
                  .filter { |item| item.date == @date }
                  .map do |item|
                    [item.title, item.price, item.publisher_agent, item.date]
                  end
    )
  end
end
