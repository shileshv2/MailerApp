require 'spec_helper'

describe User do
	before(:each) do
		@valid_params = {:user_name => "Example user", :email => "user@example.com", :password => "example"}
	end

	it "should create user with valid params" do
		User.find_by_email("user@example.com").should be_nil
		User.create @valid_params
		User.find_by_email("user@example.com").user_name.should == "xyz"  # should fail

	end

	it "when email format is invalid" do
		@valid_params["email"] = "xyz"
		#User.create(@valid_params)
		#User.find_by_email("xyz").should be_nil	
		User.new.should_not be_valid
	end

	it "when username is not present" do
		@valid_params[:user_name] = nil
		User.create(@valid_params)
		User.find_by_email("user@example.com").should be_nil
	end

	it "when password is not present" do
		@valid_params[:password] = nil
		User.create(@valid_params)
		User.find_by_email("user@example.com").should be_nil
	end


	it "when name is too short" do
		@valid_params[:user_name] = "a"
		User.create @valid_params
		User.find_by_email("user@example.com").should be_nil
	end

	it "user with same name" do
		duplicate_username = @valid_params.dup
		User.create @valid_params
		User.find_by_email("user@example.com").should_not be_nil
		User.create duplicate_username
		#User.count { |rec| rec.email == "user@example.com"}.should == 1
		User.count(:conditions => "email='user@example.com'").should == 1
		expect 
	end	

	it "when password doesn't match confirmation" do
		@valid_params[:password_confirmation] = 'mismatch'
		User.create @valid_params
		User.find_by_email("user@example.com").should be_nil
	end
end



 


	# subject { @user }

	# it { should be_valid } 

	# describe "when username is not present" do
	# 	before { @user.user_name = "" }
	# 	it { should_not be_valid }
	# end

	# describe "when password is not present" do
	# 	before { @user.password = "" }
	# 	it { should_not be_valid }
	# end

	# describe "when name is too short" do
	# 	before { @user.user_name = "a" }
	# 	it { should_not be_valid }
	# end

