class RequireItemValidator < ActiveModel::Validator
	def validate(record)
		if record.items.empty?
			record.errors[:items] << 'The order must contain an item'
		end
	end
end

class Order < ActiveRecord::Base	
  attr_accessible :nom
  belongs_to :user
  has_and_belongs_to_many :items
  validates :nom, :presence => true
  validates_with RequireItemValidator

end