class AddFixedFeeToConveyancingQuotes < ActiveRecord::Migration
  def self.up
    add_column :conveyancing_quotes, :fixed_fee, :float, :default => 0
  end

  def self.down
    remove_column :conveyancing_quotes, :fixed_fee
  end
end
