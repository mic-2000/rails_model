class Item < ActiveRecord::Base
  attr_accessible :name, :description, :price
  
  has_and_belongs_to_many :orders

  validates :name, :presence => true
  validates :price, :presence => true, :format => /\A-?\d+[(.|,)?]?\d{1,2}\z/

  scope :popular,	Item.select('items.*, count(items_orders.order_id)').joins('INNER JOIN items_orders ON Items.id = items_orders.item_id').group('Items.id').order('count(items_orders.order_id) DESC')
  
end
