class AddHighlightLinkToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :highlight_link, :text
  end

  def self.down
    remove_column :page_contents, :highlight_link
  end
end
