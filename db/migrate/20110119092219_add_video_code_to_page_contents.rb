class AddVideoCodeToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :video_code, :text
  end

  def self.down
    remove_column :page_contents, :video_code
  end
end
