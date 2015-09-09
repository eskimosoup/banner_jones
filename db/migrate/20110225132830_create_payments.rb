class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|

      t.string :code
      t.text :gateway_reply
      t.string :invoice_number
      t.float :amount
      t.string :company_name
      t.string :contact_number      
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
    drop_table :payments
  end
end
