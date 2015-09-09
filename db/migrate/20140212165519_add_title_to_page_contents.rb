class AddTitleToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :page_main_title, :string
  end

  def self.down
    remove_column :page_contents, :page_main_title
  end
end
