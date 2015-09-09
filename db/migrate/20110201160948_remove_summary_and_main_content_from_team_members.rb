class RemoveSummaryAndMainContentFromTeamMembers < ActiveRecord::Migration
  def self.up
    remove_column :team_members, :summary
    remove_column :team_members, :main_content
  end

  def self.down
    add_column :team_members, :main_content, :text
    add_column :team_members, :summary, :text
  end
end
