class AddTeamGoogleToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :google_link, :string
  end

  def self.down
    remove_column :team_members, :google_link
  end
end
