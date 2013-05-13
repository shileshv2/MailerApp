class RemoveDefaultValueOfTextMessageBodyColumn < ActiveRecord::Migration
  def self.up
    change_column_default :text_message_templates, :text_message_body, nil
  end

  def self.down
  end
end
