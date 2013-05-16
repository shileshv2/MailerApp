class CreateUploadImage < ActiveRecord::Migration
  def self.up
    create_table :upload_images do |t|
      t.string   :tagline
      t.string   :uploaded_image_file_name
      t.string   :uploaded_image_content_type
      t.integer  :uploaded_image_file_size
      t.datetime :uploaded_image_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :upload_images
  end
end
