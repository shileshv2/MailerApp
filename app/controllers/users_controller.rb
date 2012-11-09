class UsersController < ApplicationController
before_filter :authorize, :only => [:show]

def authorize
 	unless User.find_by_id(session[:user_id])
	   redirect_to root_path, :notice => "Please log in"
  end

  if session[:user].user_type == 'guest'
    render :text => 'Unauthorized access'
  end
end


def show
   @user = User.find(:all)

end

def new
  @user = User.new
 
end

def create
   @user = User.new(params[:user]) 

    
    @user.salt = @user.generate_salt
     @user.password = @user.encrypt_password(params[:user][:password])
     @user.password_confirmation = @user.encrypt_password(params[:user][:password_confirmation])

    respond_to do |format|  
      if @user.save 
        format.html { redirect_to root_path, :notice => "Registered successfully" }
      else
        format.html { render :action => "new" }  # doesn't execute the new method
      end
    end
end

def save_password
  @user = User.find(params[:id])
  unless params[:update_user].blank?

    #if (@user.password.to_s.eql?(params[:update_user][:old_password].to_s) && 
    if (@user.password_correct?(params[:update_user][:old_password]) &&
      params[:update_user][:new_password].eql?(params[:update_user][:confirm_password]))
      puts "password matched"
       if @user.update_attributes(:password => @user.encrypt_password(params[:update_user][:new_password]))
        flash.now[:notice]="Password Changed Successfully"
        render :template => "/users/guest"
      else 
        puts "unable to save password"
      end
    else
      puts "password doesn't match"
      flash.now[:notice] = "Password doesn't match" 
      render :template => "/users/change_password"
    end 
  end
end
end