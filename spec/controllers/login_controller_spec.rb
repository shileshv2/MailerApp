require 'spec/spec_helper'

describe LoginController do

	fixtures :users

	before :each do
		@user = users(:user1)
	end 

	it "should login guest successfully" do
		post :perform_login, :user => {:user_name => @user.user_name, :password => 'password'}
		response.session[:user_id].should == 1
		response.should render_template('users/guest')
	end

	it "should not login user with incorrect password" do
		post :perform_login, :user => {:user_name => @user.user_name, :password => 'wrong password'}
		response.flash[:alert].should == "Username/password do not match"
		response.should redirect_to(root_path)
	end

	it "should login admin successfully" do
		@user = users(:user2)
		post :perform_login, :user => {:user_name => @user.user_name, :password => 'password'}
		@user.user_type == 'admin'
		response.session[:user_id].should == 2
		response.should render_template('users/admin')
	end

	it "should flash error message when username is invalid" do
		post :perform_login, :user => {:user_name => 'wrong user'}
		response.flash[:alert].should == "Invalid user"
	end
end
