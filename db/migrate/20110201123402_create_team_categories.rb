class CreateTeamCategories < ActiveRecord::Migration
  def self.up
    create_table :team_categories do |t|

      t.string :name

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
    drop_table :team_categories
  end
end