class CreateOffices < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|

      t.string :name

      t.text :address

      t.string :postcode

      t.string :phone

      t.text :directions

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
    drop_table :offices
  end
end