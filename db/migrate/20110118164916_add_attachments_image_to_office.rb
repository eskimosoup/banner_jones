class AddAttachmentsImageToOffice < ActiveRecord::Migration
  def self.up
    add_column :offices, :image_file_name, :string
    add_column :offices, :image_content_type, :string
    add_column :offices, :image_file_size, :integer
    add_column :offices, :image_updated_at, :datetime
    add_column :offices, :image_alt, :string
  end

  def self.down
    remove_column :offices, :image_file_name
    remove_column :offices, :image_content_type
    remove_column :offices, :image_file_size
    remove_column :offices, :image_updated_at
    remove_column :offices, :image_alt
  end
end
