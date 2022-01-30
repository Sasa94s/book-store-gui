require_relative 'store_item'

class Magazine < StoreItem
  attr_accessor :publisher_agent, :date

  def initialize(title, price, publisher_agent, date)
    super(title, price)
    @publisher_agent = publisher_agent
    @date = date
  end

  def to_s
    "title=#{@title}, price=#{@price}, publisher_agent=#{@publisher_agent}, date=#{@date}"
  end

  def to_item
    [@title, @price, "Publisher: #{@publisher_agent}, Date: #{@date}"]
  end
end
