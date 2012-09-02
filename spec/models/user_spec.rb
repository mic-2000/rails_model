require 'spec_helper'

describe User do
	context 'validate' do
	  before do
	    @user = FactoryGirl.create(:user)
	  end

	  it { should validate_presence_of(:name) }
	  it { should validate_presence_of(:email) }
	  it { should validate_uniqueness_of(:email) }
	  it { should validate_presence_of(:password) }
	  it { should validate_confirmation_of(:password) }
	      
	  it { should have_many(:orders) }
	end
  
  it "shuold return all items they bought" do
  	@user = FactoryGirl.create(:user)
  	@order1 = FactoryGirl.create(:order, :user_id => @user.id, :items =>  3.times.collect {FactoryGirl.create(:item)})
  	@order2 = FactoryGirl.create(:order, :user_id => @user.id, :items =>  5.times.collect {FactoryGirl.create(:item)})

  	@user.all_items.count.should == 8
  end

  it "should return users who ordered 2 or more items in the last 90 days" do
  	@user1 = FactoryGirl.create(:user)
  	@order1 = FactoryGirl.create(:order, 
                                 :user_id => @user1.id, 
                                 :created_at => Time.now.midnight - 30.day,
                                 :items =>  3.times.collect {FactoryGirl.create(:item)})

  	@user2 = FactoryGirl.create(:user)
  	@order2 = FactoryGirl.create(:order, 
                                 :user_id => @user2.id, 
                                 :created_at => Time.now.midnight - 30.day,
                                 :items =>  1.times.collect {FactoryGirl.create(:item)})  

  	@user3 = FactoryGirl.create(:user)
  	@order3 = FactoryGirl.create(:order, 
                                 :user_id => @user3.id, 
                                 :created_at => Time.now.midnight - 100.day,
                                 :items =>  3.times.collect {FactoryGirl.create(:item)}) 
  	
  	@user4 = FactoryGirl.create(:user)
  	@order4 = FactoryGirl.create(:order, 
                                 :user_id => @user4.id, 
                                 :created_at => Time.now.midnight - 100.day,
                                 :items =>  1.times.collect {FactoryGirl.create(:item)}) 

  	User.loyality.count.size.should == 1  	
  end
end
