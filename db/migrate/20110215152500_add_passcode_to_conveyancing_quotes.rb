class AddPasscodeToConveyancingQuotes < ActiveRecord::Migration
  def self.up
    add_column :conveyancing_quotes, :passcode, :string
  end

  def self.down
    remove_column :conveyancing_quotes, :passcode
  end
end
