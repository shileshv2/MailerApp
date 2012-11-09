class ChangeUserTypeColumn < ActiveRecord::Migration
  def self.up
    execute "alter table users alter column user_type set default 'guest'"
  end

  def self.down
    execute "alter table users alter column user_type drop default 'guest'"
  end
end
