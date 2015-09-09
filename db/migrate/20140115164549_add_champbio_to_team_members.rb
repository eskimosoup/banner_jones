class AddChampbioToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :champion_bio, :text
  end

  def self.down
    remove_column :team_members, :champion_bio
  end
end
