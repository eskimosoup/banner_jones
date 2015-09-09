class AddStatusToConveyancingQuotes < ActiveRecord::Migration
  def self.up
    add_column :conveyancing_quotes, :status, :string
  end

  def self.down
    remove_column :conveyancing_quotes, :status
  end
end
