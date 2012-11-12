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


def index 
     @users = User.find(:all)
end



def show


end



def new
  @user = User.new
end

def edit
  @user = User.find_by_id(params[:id])
end

def update
  @user = User.find(params[:id])

  respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { render :template => "/users/#{session[:user].user_type}", :notice => 'User updated successfully' }
    else
      format.html { render :action => "edit" }
    end
  end
end



def create
    @user = User.new(params[:user]) 
    @user.salt = @user.generate_salt
    @user.password = @user.encrypt_password(params[:user][:password])
    @user.password_confirmation = @user.encrypt_password(params[:user][:password_confirmation])

    respond_to do |format|  
      if @user.save 
        flash[:notice] = "Registered Successfully"
        format.html { redirect_to root_path, :notice => "Registered successfully" }
      else
        format.html { render :action => "new" }  # doesn't execute the new method
      end
    end
end

def save_password
  @user = User.find(params[:id])
  unless params[:update_user].blank?
    if (@user.password_correct?(params[:update_user][:old_password]) && params[:update_user][:new_password].eql?(params[:update_user][:confirm_password]))
      if @user.update_attributes(:password => @user.encrypt_password(params[:update_user][:new_password]))
        flash.now[:notice]="Password Changed Successfully"
        render :template => "/users/guest"
      else 
        puts "unable to save password"
      end
    else
      flash.now[:notice] = "Password doesn't match" 
      render :template => "/users/change_password"
    end 
  end
end


def destroy
  @user = User.find(params[:id])
  @user.destroy

  respond_to do |format|
    format.html { redirect_to(users_url, :notice => "User deleted")}
  end
end


end