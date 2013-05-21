class DashboardController < ApplicationController
  def index
    puts ("user is #{session[:user]}")
    unless session[:user].nil?
      if(session[:user].user_type == 'admin')
        render 'admin_home'
      else
        render 'guest_home'
      end
    else
      redirect_to "/login/index"
    end
  end
  
end