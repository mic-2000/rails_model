require 'spec_helper'

describe Item do
  context 'validate' do
    before do
      @item = FactoryGirl.create(:item)
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }  
    it { should_not allow_value('10.456').for(:price) }
    it { should allow_value('-10.45').for(:price) }
    it { should allow_value('105').for(:price) }
    it { should allow_value('10,5').for(:price) }

    it { should have_and_belong_to_many(:orders) }
  end
      
  it "should return list of most popular items" do
    3.times { FactoryGirl.create(:item) }
    @item1 = FactoryGirl.create(:item)
    @order1 = FactoryGirl.create(:order, :items => 3.times.collect { @item1 })
    @item2 = FactoryGirl.create(:item)
    @order2 = FactoryGirl.create(:order, :items => 5.times.collect { @item2 })

    Item.popular(10).count.size.should == 2
    Item.all.count.should == 5
  end
end
