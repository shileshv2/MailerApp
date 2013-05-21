require 'spec_helper'

describe Notifier do

  describe "message" do
    before(:each) do
      @valid_template_params = {:text_message_body => "Example Text Message body", :text_message_subject => "Example Text Message subject"}
      @template= TextMessageTemplate.new(@valid_template_params)
      @template.save!
      @valid_user_params = {:user_name => "Example user", :email => "user@example.com", :password => "example"}
      @user= User.new(@valid_user_params)
      @user.save!
      @body= "Happy Birthday #{@user.first_name}!!! #{@template.text_message_body}"
      @image= UploadImage.new({:uploaded_image_file_name => '123.jpeg'})
      @image.save!

      @notifier= Notifier.deliver_message(@template.text_message_subject, @body, @user, @image.uploaded_image_file_name)
    end

    it "should be send to user's email address " do
      @notifier.to.should include @user.email
    end

     it "should be the subject " do
      @notifier.subject.should include @template.text_message_subject
    end

     it "email body should be" do
      @notifier.body.should include "\n<p>Happy Birthday !!!</p>\n<p style=\"padding-top: 19px;\"></p>\n<h1><span style=\"color: #242424; font-family: Georgia; font-size: large;\">\n    <div id=\"image_box\">\n      <img alt=\"123\" src=\"/images/123.jpeg\" />\n    </div>\n  </span>\n</h1>\n"
     end

  end
  
end