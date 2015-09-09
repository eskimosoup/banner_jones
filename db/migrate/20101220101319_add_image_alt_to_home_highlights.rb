class AddImageAltToHomeHighlights < ActiveRecord::Migration
  def self.up
    add_column :home_highlights, :image_alt, :string
  end

  def self.down
    remove_column :home_highlights, :image_alt
  end
end
