# frozen_string_literal: true

require_relative 'views/main_view'
require_relative 'utils/csv_utils'

$store_items = []

class Main
  def initialize

    books = CSVUtils.read_csv('Book.csv').map { |book| Book.new(book[0], book[1], book[2], book[3], book[4]) }
    magazines = CSVUtils.read_csv('Magazine.csv').map { |mag| Magazine.new(mag[0], mag[1], mag[2], mag[3]) }
    $store_items = books + magazines
    MainView.new
  end
end

Main.new
