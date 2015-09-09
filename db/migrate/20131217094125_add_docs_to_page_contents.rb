class AddDocsToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :document_area, :text
  end

  def self.down
    remove_column :page_contents, :document_area
  end
end
