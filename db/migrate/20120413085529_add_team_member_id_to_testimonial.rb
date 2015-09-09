class AddTeamMemberIdToTestimonial < ActiveRecord::Migration
  def self.up
    create_table :team_members_testimonials, :id => false do |t|
      t.integer :team_member_id
      t.integer :testimonial_id
    end
  end

  def self.down
    drop_table :team_members_testimonials
  end
end
