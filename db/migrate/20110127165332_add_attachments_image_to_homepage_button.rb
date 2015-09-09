class AddAttachmentsImageToHomepageButton < ActiveRecord::Migration
  def self.up
    add_column :homepage_buttons, :image_file_name, :string
    add_column :homepage_buttons, :image_content_type, :string
    add_column :homepage_buttons, :image_file_size, :integer
    add_column :homepage_buttons, :image_updated_at, :datetime
    add_column :homepage_buttons, :image_alt, :string
  end

  def self.down
    remove_column :homepage_buttons, :image_file_name
    remove_column :homepage_buttons, :image_content_type
    remove_column :homepage_buttons, :image_file_size
    remove_column :homepage_buttons, :image_updated_at
    remove_column :homepage_buttons, :image_alt
  end
end
