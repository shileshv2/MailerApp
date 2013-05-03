require 'spec/spec_helper'

describe TextMessageController do

 describe "authorize" do

    fixtures :users

		before :each do
			@user = users(:user1)
		end
    
  it "authorize" do
    session[:user]= @user
    session[:user].user_type == "guest"
    render_template(:text => 'Unauthorized access')
  end
 end
  

  
end
