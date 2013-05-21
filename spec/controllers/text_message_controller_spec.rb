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
    
 end
  
end