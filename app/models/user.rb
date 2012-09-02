class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :orders
  
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true

  scope :loyality, User.select('users.*, count(items_orders.item_id) as item_count').joins('LEFT JOIN orders ON users.id = orders.user_id').joins('LEFT JOIN items_orders ON orders.id = items_orders.order_id').where('orders.created_at >= ?',Time.now.midnight - 90.day).group('users.id').having('count(items_orders.item_id) >= ?',2)    

  def all_items
  	Item.joins('INNER JOIN items_orders ON Items.id = items_orders.item_id').where('items_orders.order_id' => self.orders)
  end

end
