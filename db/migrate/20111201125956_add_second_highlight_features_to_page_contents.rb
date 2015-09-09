class AddSecondHighlightFeaturesToPageContents < ActiveRecord::Migration

  def self.up
		add_column :page_contents, :highlight_2_style, :string
		add_column :page_contents, :highlight_2_content, :text
		add_column :page_contents, :highlight_2_link, :text
		add_column :page_contents, :highlight_2_ext_link, :string
		# Images
		add_column :page_contents, :highlight_2_image_file_name, :string
		add_column :page_contents, :highlight_2_image_content_type, :string
		add_column :page_contents, :highlight_2_image_file_size, :integer
		add_column :page_contents, :highlight_2_image_updated_at, :datetime
		add_column :page_contents, :highlight_2_image_alt, :string
  end

  def self.down
		remove_column :page_contents, :highlight_2_style
		remove_column :page_contents, :highlight_2_content
		remove_column :page_contents, :highlight_2_link
		remove_column :page_contents, :highlight_2_ext_link
		# Images
		remove_column :page_contents, :highlight_2_image_file_name
		remove_column :page_contents, :highlight_2_image_content_type
		remove_column :page_contents, :highlight_2_image_file_size
		remove_column :page_contents, :highlight_2_image_updated_at
		remove_column :page_contents, :highlight_2_image_alt
  end

end
