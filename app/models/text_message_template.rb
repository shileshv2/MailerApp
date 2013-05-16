class TextMessageTemplate < ActiveRecord::Base
	validates_presence_of :text_message_subject, :text_message_body

end
