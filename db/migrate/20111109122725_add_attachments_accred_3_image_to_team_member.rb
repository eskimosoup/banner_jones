class AddAttachmentsAccred3ImageToTeamMember < ActiveRecord::Migration

  def self.up
    add_column :team_members, :accred_3_image_file_name, :string
    add_column :team_members, :accred_3_image_content_type, :string
    add_column :team_members, :accred_3_image_file_size, :integer
    add_column :team_members, :accred_3_image_updated_at, :datetime
    add_column :team_members, :accred_3_image_alt, :string
    add_column :team_members, :accred_3_link, :string
  end

  def self.down
    remove_column :team_members, :accred_3_image_file_name
    remove_column :team_members, :accred_3_image_content_type
    remove_column :team_members, :accred_3_image_file_size
    remove_column :team_members, :accred_3_image_updated_at
    remove_column :team_members, :accred_3_image_alt
    remove_column :team_members, :accred_3_link
  end

end
