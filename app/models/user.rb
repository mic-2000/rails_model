class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :orders
  has_many :items, :through => :orders
  
  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true

  scope :best_customers, lambda {
    select('users.*, count(items_orders.item_id) as item_count').
    joins(:orders => :items).
    where('orders.created_at >= ?', 3.months.ago).
    group('users.id').
    having('count(items_orders.item_id) >= ?',2)
  }

  def all_items
  	self.items
  end

end
