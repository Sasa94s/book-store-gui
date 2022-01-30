class ListView
  attr_accessor :f

  def initialize(title, header, items)
    @f = Flammarion::Engraving.new(title: title, close_on_exit: true)
    @f.markdown("<center><h1>#{title}</h1></center>")
    @f.table([header.map(&:light_magenta)] +
               items)
    @f.wait_until_closed
  end
end
