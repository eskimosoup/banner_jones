class AddSplashContentToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :splash_content, :text
    add_column :page_contents, :banner_content, :text
    add_column :page_contents, :button_content, :string
  end

  def self.down
    remove_column :page_contents, :button_content
    remove_column :page_contents, :banner_content
    remove_column :page_contents, :splash_content
  end
end
