class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def order_total
    sum = 0
    line_items.each do |line_item|
      sum += line_item.total_price
    end
    return sum
  end
end
