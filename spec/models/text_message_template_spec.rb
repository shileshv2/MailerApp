require 'spec_helper'

describe TextMessageTemplate do
  before(:each) do
		@valid_text_message_params = {:text_message_body => "Example Text Message body", :text_message_subject => "Example Text Message subject"}
    @template= TextMessageTemplate.new(@valid_text_message_params)
	end

  it "should create text message template with valid params" do
    @template.save!
    TextMessageTemplate.find_by_text_message_subject("Example Text Message subject").text_message_body.should == "Example Text Message body"
  end
  
  it "should not be valid with empty text message body" do
    @template.text_message_body = ''
    @template.should_not be_valid
  end

  it "should not be valid with empty text message subject" do
    @template.text_message_subject = ''
    @template.should_not be_valid
  end
  
end