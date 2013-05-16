class UpdateTextMessageSubjectColumnOfTextMessageTemplate < ActiveRecord::Migration
  def self.up
    sql = ActiveRecord::Base.connection();
    sql.update "update text_message_templates set text_message_body= \" <p bgcolor='#F6F4EE' style='padding-top: 19px;'>
  		  <h1><font face='Georgia' size='5' color='#242424'>{branding_box}</font></h1>Hope your birthday blossoms into lots of dreams come true. Happy Birthday!!!\" "
    
  end

  def self.down
  end
end
