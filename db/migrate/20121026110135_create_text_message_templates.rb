class CreateTextMessageTemplates < ActiveRecord::Migration
  def self.up
    create_table :text_message_templates do |t|
      t.column :template_name, :string
      t.column :text_message_subject, :string, :default => "Best Wishes!" 
	   t.column :text_message_body, :string, :default => "Hope your birthday blossoms into lots of dreams come true. Happy Birthday!!!"
      t.column :sent_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :text_message_templates
  end
end
