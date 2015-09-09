class AddMatterToLegalAidRequests < ActiveRecord::Migration
  def self.up
    add_column :legal_aid_requests, :matter, :string
  end

  def self.down
    remove_column :legal_aid_requests, :matter
  end
end
