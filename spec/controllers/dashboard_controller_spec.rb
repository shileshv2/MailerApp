require "spec/spec_helper"

describe DashboardController do

  describe "index" do

    fixtures :users

    before :each do
      @user = users(:user2)
   end

    it "should redirect login page if no session" do
      get :index
      response.should redirect_to('login/index')
    end

    it "should render admin home page" do
      session[:user] = @user
      get :index
      response.should render_template( 'admin_home')
   end

    it "should render guest home page" do
      @user = users(:user1)
      session[:user] = @user
      get :index
      response.should render_template( 'guest_home')
    end

  end

end