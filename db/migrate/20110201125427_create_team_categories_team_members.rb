class CreateTeamCategoriesTeamMembers < ActiveRecord::Migration
  def self.up
    create_table "team_categories_team_members", :id => false, :force => true do |t|
      t.integer "team_category_id"
      t.integer "team_member_id"
    end
  end

  def self.down
    drop_table "team_categories_team_members"
  end
end
