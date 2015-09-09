class CreateLegalAidRequests < ActiveRecord::Migration
  def self.up
    create_table :legal_aid_requests do |t|

      t.string :name

      t.string :postcode

      t.string :email

      t.string :phone

      t.boolean :benefits

      t.float :gross_income

      t.float :other_income

      t.float :benefits_income

      t.float :children_out

      t.float :rent_out

      t.float :people_out

      t.float :partner_out

      t.float :maintenance_out

      t.float :childcare_out

      t.float :tax_out

      t.float :house_value

      t.float :mortgage_value

      t.float :savings

      t.float :shares

      t.float :property

      t.float :bonds

      t.float :endowment

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
    drop_table :legal_aid_requests
  end
end