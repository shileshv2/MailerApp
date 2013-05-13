require 'Encryption'

class User < ActiveRecord::Base

   validates_presence_of :user_name, :password
   validates_length_of :user_name, :minimum => 5 
   validates_uniqueness_of :user_name
   validates_confirmation_of :password
   #validates_format_of :birthdate, :with => 
   validates_format_of :email, :with => /^(\S+)@(\S+)\.(\S+)$/


   def password_correct?(password_confirm)
    unless (password_confirm.nil?)
      if !self.salt.nil?
        password == Encryption.encrypt_password(password_confirm, self.salt)
      end
    end
   end


   def hasBday_today?
      return (birthdate.month.eql?(Date.today.month) && birthdate.day.eql?(Date.today.day))
   end

   def self.send_email_through_delayed_jobs
     template= TextMessageTemplate.first
     all_users= User.find_all_by_birthdate(Date.today)
     unless all_users.empty?
       all_users.each do |user|
         body = "Happy Birthday #{user.first_name}!!! #{template.text_message_body}"
         #Notifier.send_later(:deliver_message, template.text_message_subject, body , user)
         Notifier.delay.deliver_message(template.text_message_subject, body , user)
       end
     end
   end
   
end
