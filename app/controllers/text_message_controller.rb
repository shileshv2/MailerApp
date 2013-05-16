class TextMessageController < ApplicationController

before_filter :authorize, :only => [:index, :send_email]
before_filter :init, :only => [:index, :send_email]
before_filter :initialize_tinymce, :only => :index
before_filter :get_email_body, :only => [:index, :send_email]


def authorize
 	unless User.find_by_id(session[:user_id])
	 redirect_to root_path, :notice => "Please log in"
	end

  if session[:user].user_type == 'guest'
    render :text => 'Unauthorized access'
  end
end

def init
  @message = TextMessageTemplate.first
  @users = User.find(:all, :conditions => ["MONTH(birthdate)=? AND DAY(birthdate) = ?", Date.today.month, Date.today.day]); 
end

def index
  if @message.nil?
    @message = TextMessageTemplate.new
  end
end

def save
  template = TextMessageTemplate.first

  if template.nil?
    @message = TextMessageTemplate.new(:text_message_body => params[:text_message_template][:body], :text_message_subject =>params[:text_message_template][:subject])
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
      Notifier.deliver_message(@message.text_message_subject, body, user, @image_body.uploaded_image_file_name)
      htmltext += user.first_name
      htmltext += "- pass<br/>"
      flash[:notice] = "Mail sent Successfully"
    rescue Exception => e
      htmltext += user.first_name
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

def load_image
    image= UploadImage.first
    @load_image= params[:uploaded_image].original_filename
    if image.nil?
      @image= UploadImage.new(:uploaded_image_file_name => params[:uploaded_image].original_filename)
      @image.save
    else
      image.update_attributes(
      :uploaded_image_file_name => params[:uploaded_image].original_filename
      )
    end
    save_image_to_directory(params[:uploaded_image])
    flash[:notice] = "Image Uploaded"
    redirect_to '/text_message/index'
 end

  def save_image_to_directory(upload)
    File.open(Rails.root.join('public', 'images', upload.original_filename), 'w') do |file|
      file.write(upload.read)
    end
  end
  

  def get_email_body
   @image_body= UploadImage.first
  end

end