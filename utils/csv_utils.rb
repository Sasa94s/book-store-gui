# frozen_string_literal: true

require 'csv'

class CSVUtils
  def self.read_csv(file)
    rows = []
    CSV.foreach(file) do |row|
      rows << row
    end
    # puts "#{rows}"
    rows
  end
end