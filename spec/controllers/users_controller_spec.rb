require 'spec/spec_helper'

describe UsersController do

	# check here if email was sent
	describe "create" do
		it "should fail to create user without password" do
			post :create, :user => {:user_name => 'rashmi', :email => 'rashmi.agarwal@in.v2solutions.com'}
			response.should render_template('users/new')
		end	

		it "should create user successfully" do
			expect{
				post :create, :user => {:user_name => 'rashmi', :password => 'password', :password_confirmation => 'password', :email => 'rashmi.agarwal@in.v2solutions.com' }
			}.to change{User.count}.by(1)

			response.should redirect_to(root_path)
		end
	end

	describe "updates the user" do
	
		fixtures :users

		before :each do
			@users = users(:user1)
		end
		
		it "should update user succesfully" do
			session[:user] = @users
			#post :update, :user => { :id => '1', :first_name => 'user1', :last_name => 'user1', :birthdate => '3/4/1944', :email => 'user1@v2solutions.com', 
			# :phone_number => '8797979' }
			#@users.email = "user1@gmail.com"
			post :update, :id => 1
			User.new.email.should == "user1@gmail.com"
			response.should render_template('users/guest')
		end

		it "should not update user" do
			
		end
	end

end