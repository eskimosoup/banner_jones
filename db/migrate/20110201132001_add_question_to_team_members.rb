class AddQuestionToTeamMembers < ActiveRecord::Migration
  def self.up
    add_column :team_members, :q1, :text
    add_column :team_members, :q2, :text
    add_column :team_members, :q3, :text
    add_column :team_members, :q4, :text
    add_column :team_members, :q5, :text
    add_column :team_members, :q6, :text
    add_column :team_members, :q7, :text
    add_column :team_members, :q8, :text
    add_column :team_members, :q9, :text
    add_column :team_members, :q10, :text
  end

  def self.down
    remove_column :team_members, :q10
    remove_column :team_members, :q9
    remove_column :team_members, :q8
    remove_column :team_members, :q7
    remove_column :team_members, :q6
    remove_column :team_members, :q5
    remove_column :team_members, :q4
    remove_column :team_members, :q3
    remove_column :team_members, :q2
    remove_column :team_members, :q1
  end
end
