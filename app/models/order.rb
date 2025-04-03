class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items

  validates :status, presence: true

  def total_price
    order_items.includes(:menu_item).map do |item|
      item.menu_item.price * item.quantity
    end.sum
  end
end
