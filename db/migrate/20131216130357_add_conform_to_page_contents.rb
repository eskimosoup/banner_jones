class AddConformToPageContents < ActiveRecord::Migration
  def self.up
    add_column :page_contents, :display_contact, :boolean, :default => false
  end

  def self.down
    remove_column :page_contents, :display_contact
  end
end
