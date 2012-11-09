# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121107130152) do

  create_table "text_message_templates", :force => true do |t|
    t.string   "template_name"
    t.string   "text_message_subject", :default => "Best Wishes!"
    t.string   "text_message_body",    :default => "Hope your birthday blossoms into lots of dreams come true. Happy Birthday!!!"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_type",    :default => "guest"
    t.integer  "phone_number"
    t.string   "email"
    t.string   "password"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "salt"
  end

end
