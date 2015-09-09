class AddHighlightToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :highlight_content, :text
  end

  def self.down
    remove_column :page_contents, :highlight_content
  end
end
