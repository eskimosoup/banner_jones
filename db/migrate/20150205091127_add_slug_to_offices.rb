class AddSlugToOffices < ActiveRecord::Migration
  def self.up
    add_column :offices, :slug, :string
    add_index :offices, :slug
  end

  def self.down
    remove_index :offices, :slug
    remove_column :offices, :slug
  end
end
