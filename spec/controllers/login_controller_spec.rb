require 'spec/spec_helper'

describe LoginController do


	fixtures :users

		before :each do
			@users = users(:user1)

		end 

		it "guest login" do
			post :perform_login, :user => {:user_name => @users.user_name, :password => 'password'}
			response.session[:user_id].should == 1
			response.should render_template('users/guest')
		end

		it "username password dont match" do
			post :perform_login, :user => {:user_name => @users.user_name, :password => 'wrong password'}
			response.should redirect_to(root_path)
		end

		it "admin login" do
			@users = users(:user2)
			post :perform_login, :user => {:user_name => @users.user_name, :password => 'password'}
			response.session[:user_id].should == 2
			response.should render_template('users/admin')
		end

		it "invalid user" do
			post :perform_login, :user => {:user_name => 'wrong user'}
			response.flash[:alert].should == "Invalid user"

		end


end
