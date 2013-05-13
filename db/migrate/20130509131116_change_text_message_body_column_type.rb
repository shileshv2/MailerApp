class ChangeTextMessageBodyColumnType < ActiveRecord::Migration
  def self.up
    change_column :text_message_templates, :text_message_body, :text
  end

  def self.down
  end
end
