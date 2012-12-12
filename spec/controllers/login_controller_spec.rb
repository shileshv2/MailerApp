require 'spec/spec_helper'

describe LoginController do
	describe "peform login" do
		it "when guest logs in" do
			session[:user_id].should be_nil
			post :perform_login, :user => {:user_name => 'guest3', :password => 'guest'}
			session[:user_id].should_not be_nil
			response.should render_template('users/guest')
		end

		it "user should not be able to login in" do
			post :perform_login, :user => {:user_name => 'abcd', :password => 'pswd'}
			flash[:alert].should == "Username/password do not match"
			response.should redirect_to(root_path)
		end

		it "when admin logs in" do
			post :perform_login, :user => {:user_name => 'admin', :password => 'root'}
			response.should render_template('users/admin')
		end
	end
end