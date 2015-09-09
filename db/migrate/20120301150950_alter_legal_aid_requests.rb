class AlterLegalAidRequests < ActiveRecord::Migration
  def self.up
    remove_column :legal_aid_requests, :house_value
    remove_column :legal_aid_requests, :mortgage_value
    add_column :legal_aid_requests, :high_equity, :boolean
  end

  def self.down
    add_column :legal_aid_requests, :house_value, :float
    add_column :legal_aid_requests, :mortgage_value, :float
    remove_column :legal_aid_requests, :high_equity
  end
end
