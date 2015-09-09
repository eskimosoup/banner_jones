class AddPageTitleAndMetaDescriptionToOffices < ActiveRecord::Migration
  def self.up
    add_column :offices, :page_title, :string
    add_column :offices, :meta_description, :text
  end

  def self.down
    remove_column :offices, :meta_description
    remove_column :offices, :page_title
  end
end
