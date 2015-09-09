class AddHighSavingsToLegalAidRequests < ActiveRecord::Migration
  def self.up
    add_column :legal_aid_requests, :high_savings, :boolean
  end

  def self.down
    remove_column :legal_aid_requests, :high_savings
  end
end
