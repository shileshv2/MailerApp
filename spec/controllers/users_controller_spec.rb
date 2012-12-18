require 'spec/spec_helper'

describe UsersController do
	fixtures :users

	before :each do
		@user = users(:user1)
	end
		
	# check here if email was sent
	describe "create" do

		it "should fail to create user without password" do
			post :create, :user => {:user_name => 'rashmi', :email => 'rashmi.agarwal@in.v2solutions.com'} 
			response.should render_template('users/new')
		end	

		it "should redirect to login page upon successfull registration" do
			expect{
				post :create, :user => {:user_name => 'rashmi', :password => 'password', :password_confirmation => 'password', :email => 'rashmi.agarwal@in.v2solutions.com' }
			}.to change{User.count}.by(1)
			response.should redirect_to(root_path)
		end
	end

	it "#index" do
		get :index
		response.should render_template('index')
	end

	describe "updates the user" do
		fixtures :users

		before :each do
			@user = users(:user1)
		end
		
		it "should update user succesfully" do	
			session[:user] = @user
			User.stub(:find).and_return(@user)
			#@users.should_receive(:update_attributes).with("email" => "new_email@gmail.com").and_return(:true)
			put :update, :id => 1, :user => { :email => "new_email@gmail.com" }
			@user.email.should == "new_email@gmail.com"
			response.should render_template('/users/guest')
		end
	end

	describe "delete user" do
		fixtures :users

		before :each do
			@user = users(:user1)
		end

		it "should delete user" do
			User.find(@user.id)
			expect {
				delete :destroy, :id => @user.id
			}.should change(User, :count).by(-1)
		end
	end
end