class TextMessageController < ApplicationController
before_filter :authorize, :only => [:index, :send_email]
before_filter :init, :only => [:send_wish]



def authorize
 	unless User.find_by_id(session[:user_id])
	 redirect_to root_path, :notice => "Please log in"
	end

  if session[:user].user_type == 'guest'
    render :text => 'Unauthorized access'
  end
end




def init
  @message = TextMessageTemplate.find(:first)
  @user = User.find(:all, :conditions => ["MONTH(birthdate)=? AND DAY(birthdate) = ?", Date.today.month, Date.today.day]); 
end


  
def index 
  @message = TextMessageTemplate.find(:first)

  if @message.nil?
    @message = TextMessageTemplate.new
  end
end



def save
  template = TextMessageTemplate.find(:first)

  if template.nil?
    @message = TextMessageTemplate.new
    @message.text_message_subject = params[:text_message_template][:subject]
    @message.text_message_body = params[:text_message_template][:body]
    @message.sent_at = Time.now
    @message.save
  else
    template.update_attributes(
      :text_message_subject => params[:text_message_template][:subject],
      :text_message_body => params[:text_message_template][:body],
      :sent_at => Time.now
      )
  end
  flash[:notice] = "Template Updated"
  redirect_to '/text_message/index' 
end

def sendwish(userid)
  htmltext = ""
  user = User.find(userid.to_i)
  body = "Happy Birthday #{user.first_name}!!! #{@message.text_message_body}"

  if user.hasBday_today?
    begin
      Notifier.deliver_message(t.text_message_subject, body, usr)
      htmltext += usr.first_name
      htmltext += "- pass<br/>"
      flash[:notice] = "Mail sent Successfully"
    rescue Exception => e
      htmltext += usr.first_name
      htmltext += "- <span style='color:red;font-weight: bold'> fail </span><br/>"
      flash[:error] = e.message
    end
     flash[:info] = htmltext
  end
 
  redirect_to :back
end



def send_email
  selections = params[:chkbox_ids]
  unless selections.nil?
    selections.each { |userid|
      user = User.find(userid.to_i)
      if !user.nil? 
        sendwish(userid)
      end
    }
  end
end

