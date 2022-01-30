class DeleteStoreItemView
  @@title = 'Delete Store Item'
  attr_accessor :f, :type, :name

  def initialize
    @f = Flammarion::Engraving.new(title: @@title, close_on_exit: true)
    @f.markdown("<center><h1>#{@@title}</h1></center>")
    @f.button('Delete Magazine') { delete_mag }
    @f.button('Delete Book') { delete_book }
    @f.subpane('store-item-name')
    @f.button('Submit') { submit }
    @f.wait_until_closed
  end

  def delete_mag
    @type = 'MAGAZINE'
    @additional_info_pane = @f.subpane('store-item-name')
    @additional_info_pane.clear
    @additional_info_pane.show
    @additional_info_pane.puts('Store Item Name (Magazine)', replace: true)
    @additional_info_pane.input('Name') { |msg| @name = msg['text'] }
    $store_items.delete_if { |item| item.title == @name }
  end

  def delete_book
    @type = 'BOOK'
    @additional_info_pane = @f.subpane('store-item-name')
    @additional_info_pane.clear
    @additional_info_pane.show
    @additional_info_pane.puts('Store Item Name (Book)', replace: true)
    @additional_info_pane.input('Name') { |msg| @name = msg['text'] }
    $store_items.delete_if { |item| item.title == @name }
  end

  def submit
    case @type
    when 'BOOK'
      delete_book
    when 'MAGAZINE'
      delete_mag
    end
  end
end
