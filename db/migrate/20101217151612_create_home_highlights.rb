class CreateHomeHighlights < ActiveRecord::Migration
  def self.up
    create_table :home_highlights do |t|

      t.string :headline

      t.text :summary

      t.text :link

      t.string :color

      t.timestamps
      t.integer :created_by
      t.integer :updated_by
      t.boolean :recycled, :default => false
      t.datetime :recycled_at
      t.boolean :display, :default => true
      t.integer :position, :default => 0
    end
  end
  
  def self.down
    drop_table :home_highlights
  end
end
