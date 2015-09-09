class CreateConveyancingQuotes < ActiveRecord::Migration
  def self.up
    create_table :conveyancing_quotes do |t|

      t.string :title

      t.string :first_names

      t.string :last_name

      t.string :phone

      t.string :email

      t.string :date

      t.float :sale_amount

      t.float :purchase_amount
      
      t.float :remortgage_amount

      t.float :equity_amount

      t.string :conveyancing_type

      t.float :stamp_duty

      t.float :land_reg_fees

      t.float :sale_fees

      t.float :purchase_fees

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
    drop_table :conveyancing_quotes
  end
end
