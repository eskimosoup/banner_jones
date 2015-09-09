class AddVideoIdToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :video_id, :integer
    remove_column :page_contents, :video_code
  end

  def self.down
    remove_column :page_contents, :video_id
    add_column :page_contents, :video_code, :text
  end
end
