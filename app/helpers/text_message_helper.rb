module TextMessageHelper

  def get_text_message_template_body
    email_body= render(:partial => 'text_message/email_body')
    if @message.text_message_body.index('{branding_box}').nil?
      return @message.text_message_body if (chunks = @message.text_message_body.split("<div id=\"image_box\">")).size <= 1
      everything_before_image_box = chunks.shift
      chunks = chunks.shift.split("</div>")
      chunks.shift
      everything_after_image_box = chunks.join('</div>')
      trailing_close_div = everything_before_image_box.start_with?("<div") ? '</div>' : ''
      everything_before_image_box + email_body + everything_after_image_box + trailing_close_div
    else
      @message.text_message_body.to_s.gsub('{branding_box}', email_body)
    end
  end
  
end