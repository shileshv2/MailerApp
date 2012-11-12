module Encryption
	def self.generate_salt 
     # self.salt = self.object_id.to_s + rand.to_s
      ActiveSupport::SecureRandom.base64(8)
   	end

   	def self.encrypt_password(password, salt)
    	#unless salt.nil?
      		Digest::SHA2.hexdigest(password + salt) 
    	#end
   	end
end