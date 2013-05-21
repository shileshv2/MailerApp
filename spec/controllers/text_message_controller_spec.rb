require 'spec/spec_helper'

describe TextMessageController do

 describe "authorize" do

    fixtures :users

		before :each do
			@user = users(:user2)
		end
    
  it "should redirect to root" do
    session[:user] = @user
    get :authorize
    response.should redirect_to root_path
  end

  it "should render text unauthorized access for guest" do
    @user = users(:user1)
    session[:user_id] = @user.id
    session[:user] = @user
    get :authorize
    response.body.should == 'Unauthorized access'
  end
    
 end
  
end