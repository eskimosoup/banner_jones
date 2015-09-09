class AddTeamCatToTeamMember < ActiveRecord::Migration
  def self.up
    add_column :team_members, :team_catagory, :string
  end

  def self.down
    remove_column :team_members, :team_catagory
  end
end
