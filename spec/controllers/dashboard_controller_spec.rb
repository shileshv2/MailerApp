require "spec/spec_helper"

describe DashboardController do

  describe "index" do

    fixtures :users

    before :each do
		@user = users(:user2)
   end

    it "should redirect admin to admin home page" do
      session[:user]= @user
      session[:user].user_type.should == "admin"
      render_template('admin_home')
    end
    
  end

  describe "index" do

    fixtures :users

    before :each do
		@user = users(:user1)
   end

    it "should redirect guest to guest home page" do
      session[:user]= @user
      session[:user].user_type.should == "guest"
      render_template('guest_home')
    end

  end

end