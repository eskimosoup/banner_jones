class CreateJobsOffices < ActiveRecord::Migration
  def self.up
    remove_column :jobs, :office_id
    create_table "jobs_offices", :id => false, :force => true do |t|
      t.integer "job_id"
      t.integer "office_id"
    end
  end

  def self.down
    add_column :jobs, :office_id, :integer
    drop_table "jobs_offices"
  end
end
