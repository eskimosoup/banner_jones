class CreatePageNodesTeamMembers < ActiveRecord::Migration
  def self.up
    create_table "page_nodes_team_members", :id => false, :force => true do |t|
      t.integer "page_node_id"
      t.integer "team_member_id"
    end
  end

  def self.down
    drop_table "page_nodes_team_members"
  end
end
