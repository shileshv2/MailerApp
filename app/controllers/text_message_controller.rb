class TextMessageController < ApplicationController
before_filter :authorize, :only => [:index, :send_email]
before_filter :init



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

  if @message.nil?
    @message = TextMessageTemplate.new
  end
end



def save
  t = TextMessageTemplate.find(:first)
  if t.nil?
    @message = TextMessageTemplate.new
    @message.text_message_subject = params[:text_message_template][:subject]
    @message.text_message_body = params[:text_message_template][:body]
    @message.sent_at = Time.now
    @message.save
  else
    t.update_attributes(
      :text_message_subject => params[:text_message_template][:subject],
      :text_message_body => params[:text_message_template][:body],
      :sent_at => Time.now
      )
  end
  flash[:notice] = "Template Updated"
  redirect_to '/text_message/index' 
end



  def send_email 
  	 #@user = User.find(:all, :conditions => ["birthdate = ?", "1995-07-23" ])
    t = TextMessageTemplate.find(:first)

    htmltext = ""

    filter = params[:name]
    for f in filter
      puts "filter #{f} "

      @user.each_with_index do |usr, i|
        if usr.id == f.to_i
          puts "filter #{f}"
          body = "Happy Birthday #{usr.first_name}!!! #{t.text_message_body}"
          begin
           @test = Notifier.deliver_message(t.text_message_subject, body, usr)
           htmltext += usr.first_name
           htmltext += "- pass<br/>"
            #flash[:notice] = "Mail sent Successfully"
          rescue Exception => e
            #raise e if raise_delivery_errors
            puts "delivery error"
            htmltext += usr.first_name
            htmltext += "- <span style='color:red;font-weight: bold'> fail </span><br/>"
            flash[:error] = e.message

          end
        end
      end
      flash[:info] = htmltext
    end
      redirect_to :back
    
  end 
end
