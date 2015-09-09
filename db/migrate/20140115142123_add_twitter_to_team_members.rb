class AddTwitterToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :twitter_link, :string
  end

  def self.down
    remove_column :team_members, :twitter_link
  end
end
