class AddHighlightExternalLinkToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :highlight_external_link, :string
  end

  def self.down
    remove_column :page_contents, :highlight_external_link
  end
end
