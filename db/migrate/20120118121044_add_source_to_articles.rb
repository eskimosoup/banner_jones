class AddSourceToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :source, :string, :default => "admin"
  end

  def self.down
    remove_column :articles, :source
  end
end
