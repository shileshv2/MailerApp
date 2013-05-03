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

      @notifier= Notifier.deliver_message(@template.text_message_subject, @body, @user)
    end

    it "should be from rashmiagar@... " do
      @notifier.from.should include "rashmiagar@gmail.com"
    end

    it "should be send to user's email address " do
      @notifier.to.should include @user.email
    end

     it "should be the subject " do
      @notifier.subject.should include @template.text_message_subject
    end

     it "email body should be" do
      @notifier.body.should include @body
     end

  end
  
end