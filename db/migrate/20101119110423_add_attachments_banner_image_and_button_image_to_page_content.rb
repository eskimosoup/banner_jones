class AddAttachmentsBannerImageAndButtonImageToPageContent < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :banner_image_file_name, :string
    add_column :page_contents, :banner_image_content_type, :string
    add_column :page_contents, :banner_image_file_size, :integer
    add_column :page_contents, :banner_image_updated_at, :datetime
    add_column :page_contents, :banner_image_alt, :string
    add_column :page_contents, :button_image_file_name, :string
    add_column :page_contents, :button_image_content_type, :string
    add_column :page_contents, :button_image_file_size, :integer
    add_column :page_contents, :button_image_updated_at, :datetime
    add_column :page_contents, :button_image_alt, :string
  end

  def self.down
    remove_column :page_contents, :banner_image_file_name
    remove_column :page_contents, :banner_image_content_type
    remove_column :page_contents, :banner_image_file_size
    remove_column :page_contents, :banner_image_updated_at
    remove_column :page_contents, :banner_image_alt
    remove_column :page_contents, :button_image_file_name
    remove_column :page_contents, :button_image_content_type
    remove_column :page_contents, :button_image_file_size
    remove_column :page_contents, :button_image_updated_at
    remove_column :page_contents, :button_image_alt
  end
end
