class User < ActiveRecord::Base

   validates_presence_of :user_name, :password
   validates_length_of :user_name, :minimum => 5 
   validates_uniqueness_of :user_name
   validates_confirmation_of :password
   #validates_format_of :birthdate, :with => 
   validates_format_of :email, :with => /^(\S+)@(\S+)\.(\S+)$/

   def generate_salt 
     # self.salt = self.object_id.to_s + rand.to_s
      ActiveSupport::SecureRandom.base64(8)
   end

   def encrypt_password(password)
    unless salt.nil?
      Digest::SHA2.hexdigest(password + salt) 
    end   
   end


   def password_correct?(password_confirm)
    unless password_confirm.empty?
      password == encrypt_password(password_confirm)
    end
   end


   def hasBday_today?
      #@user = find(:all, :conditions => ["MONTH(birthdate)=? AND DAY(birthdate) = ?", Date.today.month, Date.today.day])
      return (birthdate.month.eql?(Date.today.month) && birthdate.day.eql?(Date.today.day))
   end
end
