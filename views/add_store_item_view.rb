# frozen_string_literal: true

require 'flammarion'
require_relative '../models/book'
require_relative '../models/magazine'

class AddStoreItemView
  @@title = 'Add Store Item'
  attr_accessor :f, :type,
                :s_title, :s_price, :s_publisher, :s_date, :s_author_name, :s_number_of_pages, :s_isbn

  def initialize
    @f = Flammarion::Engraving.new(title: @@title, close_on_exit: true)
    @f.markdown("<center><h1>#{@@title}</h1></center>")
    @f.subpane('switcher').puts('Switch to', replace: true)
    @f.subpane('switcher').button('Magazine') { switch_to_magazine }
    @f.subpane('switcher').button('Book Store') { switch_to_book_store }
    @f.subpane('main-info').puts('Main Info', replace: true)
    @f.subpane('main-info').input('Title') { |msg| @s_title = msg['text'] }
    @f.subpane('main-info').input('Price') { |msg| @s_price = msg['text'] }
    switch_to_book_store
    @f.button('Add') { add_store_item }
    @f.wait_until_closed
  end

  def switch_to_magazine
    @type = 'MAGAZINE'
    @additional_info_pane = @f.subpane('additional-info')
    @additional_info_pane.clear
    @additional_info_pane.show
    @additional_info_pane.puts('Additional Info (Magazine)', replace: true)
    @additional_info_pane.input('Publisher Agent') { |msg| @s_publisher = msg['text'] }
    @additional_info_pane.input('Date') { |msg| @s_date = msg['text'] }
  end

  def switch_to_book_store
    @type = 'BOOK'
    @additional_info_pane = @f.subpane('additional-info')
    @additional_info_pane.clear
    @additional_info_pane.show
    @additional_info_pane.puts('Additional Info (Book Store)', replace: true)
    @additional_info_pane.input('Author Name') { |msg| @s_author_name = msg['text'] }
    @additional_info_pane.input('Number of Pages') { |msg| @s_number_of_pages = msg['text'] }
    @additional_info_pane.input('ISBN') { |msg| @s_isbn = msg['text'] }
  end

  def add_store_item
    puts 'Add clicked'
    puts "Type: #{@type}"
    case @type
    when 'BOOK'
      @store_item = Book.new(@s_title, @s_price, @s_author_name, @s_number_of_pages, @s_isbn)
    when 'MAGAZINE'
      @store_item = Magazine.new(@s_title, @s_price, @s_publisher, @s_date)
    end

    $store_items.append(@store_item) if @store_item
    puts $store_items
  end
end
