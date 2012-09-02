require 'spec_helper'

describe Order do
	context "default validate" do
	  before do
	    @order = FactoryGirl.create(:order, :items => [FactoryGirl.create(:item)])
	  end

	  it { should validate_presence_of(:nom) }

	  it { should belong_to(:user) }
	  it { should have_and_belong_to_many(:items) }
	end
	
	context "The order must contain an item" do
		it "should be valid" do
			@order = FactoryGirl.build(:order)
			@order.should be_valid
		end
		it "should not be valid" do
			@order = FactoryGirl.build(:order, :items => [])
			@order.should_not be_valid
		end
	end

end
