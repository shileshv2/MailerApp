class DashboardController < ApplicationController
  def index
    puts ("user is #{session[:user]}")
    if(session[:user].user_type == 'admin')
			render 'admin_home'
    else
        render 'guest_home'
    end
  end
end
