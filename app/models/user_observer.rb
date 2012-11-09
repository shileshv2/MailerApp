class UserObserver < ActiveRecord::Observer
  def after_create(user)
    TextMessageTemplate.deliver_welcome_email(user)
  end
end
