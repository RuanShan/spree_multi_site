require 'spec_helper'

describe Spree::Site do
  before(:each) do
    @site = Spree::Site.new(:name=>'ABC',:domain=>'www.abc.net')
  end

  it "should be valid" do
    @site.should be_valid
  end
  
  it "should create site and user" do
    user_attributes = {"email"=>"test@abc.com", "password"=>"a12345z", "password_confirmation"=>"a12345z"}
    @site.users_attribute = user_attributes
    @site.should be_save
    @site.users.first.email.should eq(user_attributes['email'])
  end
  
end
