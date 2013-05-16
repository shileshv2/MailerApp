class Notifier < ActionMailer::Base

  def message(sub, email_body, user, uploaded_image)
    recipients user.email
    from "rashmiagar@gmail.com"
    subject sub
    sent_on Time.now
    content_type "multipart/mixed"

    part "text/html" do |p|
           p.body = render_message("text_html", :email_body => email_body)
    end
    
    attachment :content_type => 'application/image',
             :body => File.read("#{RAILS_ROOT}/public/images/#{uploaded_image}"),
             :filename => uploaded_image
  end


end