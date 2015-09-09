class AddAlternateHeaderToPageNode < ActiveRecord::Migration
  def self.up
    add_column :page_nodes, :alternate_header, :boolean
  end

  def self.down
    remove_column :page_nodes, :alternate_header
  end
end
