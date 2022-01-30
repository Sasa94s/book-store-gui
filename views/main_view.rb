# frozen_string_literal: true

require 'flammarion'
require_relative 'add_store_item_view'
require_relative 'list_view'
require_relative 'list_books_with_range_view'
require_relative 'search_magazine_by_date_view'
require_relative 'search_magazine_by_publisher_view'
require_relative 'delete_store_item_view'

class MainView
  @@title = 'Book Store'

  def initialize
    f = Flammarion::Engraving.new(title: @@title, exit_on_disconnect: true)
    f.orientation = :horizontal
    f.markdown("<center><h1>#{@@title}</h1></center>")
    f.button('Add Store Item') { AddStoreItemView.new }
    f.button('List Most Expensive Items') do
      ListView.new(
        'List Most Expensive Items',
        %w[Title Price], $store_items.map { |item| [item.title, item.price] }.sort_by { |s| -s[1] }
      )
    end
    f.button('List Books with Certain Range') { ListBooksWithRangeView.new }
    f.button('Search Magazine by Date') { SearchMagazineByDateView.new }
    f.button('Search Magazine by Publisher') { SearchMagazineByPublisherView.new }
    f.button('List Store Items') do
      ListView.new(
        'List Store Items',
        %w[Title Price AdditionalInfo],
        $store_items.map { |item| item.to_item }
      )
    end
    f.button('Delete Store Item') { DeleteStoreItemView.new }
    f.wait_until_closed
  end
end
