class AddContactedToLegalAirRequests < ActiveRecord::Migration
  def self.up
    add_column :legal_aid_requests, :contacted, :boolean, :default => false
  end

  def self.down
    remove_column :legal_aid_requests, :contacted
  end
end
