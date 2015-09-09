class AddRichSnippetToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :rich_snippet, :text
  end

  def self.down
    remove_column :page_contents, :rich_snippet
  end
end
