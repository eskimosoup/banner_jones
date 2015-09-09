class ChangeLegalAidRequests < ActiveRecord::Migration
  def self.up
    add_column :legal_aid_requests, :divorce, :boolean
    add_column :legal_aid_requests, :children, :boolean
    add_column :legal_aid_requests, :injunctions, :boolean
  end

  def self.down
    remove_column :legal_aid_requests, :divorce
    remove_column :legal_aid_requests, :children
    remove_column :legal_aid_requests, :injunctions
  end
end
