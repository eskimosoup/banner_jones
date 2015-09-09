class AddHighlightStyleToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :highlight_style, :string
  end

  def self.down
    remove_column :page_contents, :highlight_style
  end
end
