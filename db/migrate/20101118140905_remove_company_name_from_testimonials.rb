class RemoveCompanyNameFromTestimonials < ActiveRecord::Migration
  def self.up
    remove_column :testimonials, :company_name
  end

  def self.down
    add_column :testimonials, :company_name, :string
  end
end
