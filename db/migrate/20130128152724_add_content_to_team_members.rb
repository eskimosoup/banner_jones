class AddContentToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :specialism_content, :text
    add_column :team_members, :case_successes_content, :text
  end

  def self.down
    remove_column :team_members, :case_successes_content
    remove_column :team_members, :specialism_content
  end
end
