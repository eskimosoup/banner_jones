class CreateHomepageButtons < ActiveRecord::Migration
  def self.up
    create_table :homepage_buttons do |t|

      t.string :internal_link

      t.string :external_link

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
    drop_table :homepage_buttons
  end
end