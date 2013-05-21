class Notifier < ActionMailer::Base

  def message(sub, email_body, user, uploaded_image)
    recipients user.email
    from "test123@domain.com"
    subject sub
    sent_on Time.now
    content_type "multipart/mixed"

    part "text/html" do |p|
           p.body = render_message("text_html", :email_body => get_email_body(email_body), :image => uploaded_image, :user => user)
    end
    
    inline_attachment :content_type => "image/jpeg",
    :body => File.read("#{RAILS_ROOT}/public/images/#{uploaded_image}"),
    :filename => "#{uploaded_image}",
    :cid => "#{uploaded_image}"

  end


  def get_email_body(body)
    body_content= body.split("</h1>")
    body_before_alt_in_img=body_content.shift
    body_after_alt_in_img= body_content.shift
    return (body_after_alt_in_img)
  end
end