# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150205095146) do

  create_table "administrators", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "last_login_at"
    t.integer  "login_count",        :default => 0
    t.boolean  "super_admin",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "css"
    t.string   "perishable_token",   :default => "",    :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  add_index "administrators", ["perishable_token"], :name => "index_administrators_on_perishable_token"

  create_table "administrators_roles", :id => false, :force => true do |t|
    t.integer "administrator_id"
    t.integer "role_id"
  end

  create_table "articles", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "main_content"
    t.date     "date",               :default => '2010-11-15'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "source",             :default => "admin"
  end

  create_table "blog_entries", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "main_content"
    t.date     "date",               :default => '2010-11-15'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
  end

  create_table "case_studies", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "main_content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
  end

  create_table "conveyancing_quotes", :force => true do |t|
    t.string   "title"
    t.string   "first_names"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "date"
    t.float    "sale_amount"
    t.float    "purchase_amount"
    t.float    "remortgage_amount"
    t.float    "equity_amount"
    t.string   "conveyancing_type"
    t.float    "stamp_duty"
    t.float    "land_reg_fees"
    t.float    "sale_fees"
    t.float    "purchase_fees"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",          :default => false
    t.datetime "recycled_at"
    t.boolean  "display",           :default => true
    t.integer  "position",          :default => 0
    t.string   "passcode"
    t.float    "fixed_fee",         :default => 0.0
    t.string   "status"
  end

  create_table "documents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "document_content_type"
    t.string   "document_file_name"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "main_content"
    t.date     "start_date",         :default => '2010-11-15'
    t.date     "end_date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
  end

  create_table "faqs", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.integer  "position",         :default => 0
    t.boolean  "super_admin_only", :default => false
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menu",             :default => true
    t.boolean  "permission",       :default => true
    t.string   "location"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",         :default => false
    t.datetime "recycled_at"
    t.boolean  "display",          :default => true
  end

  create_table "features_roles", :id => false, :force => true do |t|
    t.integer "feature_id"
    t.integer "role_id"
  end

  create_table "glossary_items", :force => true do |t|
    t.string   "word"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "home_highlights", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "link"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  create_table "homepage_buttons", :force => true do |t|
    t.string   "internal_link"
    t.string   "external_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "main_content"
    t.date     "closing_date"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                      :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                       :default => true
    t.integer  "position",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "application_pack_file_name"
    t.string   "application_pack_content_type"
    t.integer  "application_pack_file_size"
    t.datetime "application_pack_updated_at"
    t.string   "application_pack_alt"
  end

  create_table "jobs_offices", :id => false, :force => true do |t|
    t.integer "job_id"
    t.integer "office_id"
  end

  create_table "legal_aid_requests", :force => true do |t|
    t.string   "name"
    t.string   "postcode"
    t.string   "email"
    t.string   "phone"
    t.boolean  "benefits"
    t.float    "gross_income"
    t.float    "other_income"
    t.float    "benefits_income"
    t.float    "children_out"
    t.float    "rent_out"
    t.float    "people_out"
    t.float    "partner_out"
    t.float    "maintenance_out"
    t.float    "childcare_out"
    t.float    "tax_out"
    t.float    "savings"
    t.float    "shares"
    t.float    "property"
    t.float    "bonds"
    t.float    "endowment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",        :default => false
    t.datetime "recycled_at"
    t.boolean  "display",         :default => true
    t.integer  "position",        :default => 0
    t.boolean  "contacted",       :default => false
    t.string   "matter"
    t.boolean  "high_equity"
    t.boolean  "high_savings"
    t.boolean  "divorce"
    t.boolean  "children"
    t.boolean  "injunctions"
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "postcode"
    t.string   "phone"
    t.text     "directions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.string   "slug"
    t.string   "page_title"
    t.text     "meta_description"
  end

  add_index "offices", ["slug"], :name => "index_offices_on_slug"

  create_table "page_contents", :force => true do |t|
    t.string   "navigation_title"
    t.string   "url_title"
    t.string   "title"
    t.integer  "page_node_id"
    t.boolean  "completed",                      :default => false
    t.boolean  "published",                      :default => false
    t.boolean  "active",                         :default => false
    t.datetime "last_updated_at",                :default => '2010-04-29 08:55:42'
    t.text     "main_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta_description"
    t.text     "meta_tags"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                       :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                        :default => true
    t.integer  "position",                       :default => 0
    t.text     "highlight_content"
    t.string   "highlight_image_file_name"
    t.string   "highlight_image_content_type"
    t.integer  "highlight_image_file_size"
    t.datetime "highlight_image_updated_at"
    t.string   "highlight_image_alt"
    t.string   "highlight_style"
    t.string   "banner_image_file_name"
    t.string   "banner_image_content_type"
    t.integer  "banner_image_file_size"
    t.datetime "banner_image_updated_at"
    t.string   "banner_image_alt"
    t.string   "button_image_file_name"
    t.string   "button_image_content_type"
    t.integer  "button_image_file_size"
    t.datetime "button_image_updated_at"
    t.string   "button_image_alt"
    t.text     "splash_content"
    t.text     "banner_content"
    t.string   "button_content"
    t.text     "highlight_link"
    t.string   "highlight_external_link"
    t.integer  "video_id"
    t.string   "highlight_2_style"
    t.text     "highlight_2_content"
    t.text     "highlight_2_link"
    t.string   "highlight_2_ext_link"
    t.string   "highlight_2_image_file_name"
    t.string   "highlight_2_image_content_type"
    t.integer  "highlight_2_image_file_size"
    t.datetime "highlight_2_image_updated_at"
    t.string   "highlight_2_image_alt"
    t.boolean  "display_contact",                :default => false
    t.text     "document_area"
    t.string   "page_main_title"
    t.text     "rich_snippet"
  end

  create_table "page_nodes", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "parent_id"
    t.integer  "position",              :default => 0
    t.string   "action"
    t.string   "controller"
    t.string   "model"
    t.string   "layout"
    t.boolean  "display",               :default => false
    t.boolean  "display_in_navigation", :default => true
    t.boolean  "can_be_moved",          :default => true
    t.boolean  "can_be_edited",         :default => true
    t.boolean  "can_be_deleted",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_key"
    t.string   "stylesheet"
    t.boolean  "can_have_children",     :default => true
    t.boolean  "special_menu",          :default => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",              :default => false
    t.datetime "recycled_at"
    t.boolean  "alternate_header"
  end

  create_table "page_nodes_team_members", :id => false, :force => true do |t|
    t.integer "page_node_id"
    t.integer "team_member_id"
  end

  create_table "payments", :force => true do |t|
    t.string   "code"
    t.text     "gateway_reply"
    t.string   "invoice_number"
    t.float    "amount"
    t.string   "company_name"
    t.string   "contact_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",       :default => false
    t.datetime "recycled_at"
    t.boolean  "display",        :default => true
    t.integer  "position",       :default => 0
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "all_features", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",     :default => false
    t.datetime "recycled_at"
    t.boolean  "display",      :default => true
  end

  create_table "site_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "super_admin_only", :default => true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",         :default => false
    t.datetime "recycled_at"
    t.boolean  "display",          :default => true
    t.string   "input_type",       :default => "text_area"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "team_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "team_categories_team_members", :id => false, :force => true do |t|
    t.integer "team_category_id"
    t.integer "team_member_id"
  end

  create_table "team_members", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "email"
    t.string   "telephone"
    t.string   "office"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                     :default => true
    t.integer  "position",                    :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.string   "casual_image_file_name"
    t.string   "casual_image_content_type"
    t.integer  "casual_image_file_size"
    t.datetime "casual_image_updated_at"
    t.string   "casual_image_alt"
    t.text     "q1"
    t.text     "q2"
    t.text     "q3"
    t.text     "q4"
    t.text     "q5"
    t.text     "q6"
    t.text     "q7"
    t.text     "q8"
    t.text     "q9"
    t.text     "q10"
    t.string   "accred_1_image_file_name"
    t.string   "accred_1_image_content_type"
    t.integer  "accred_1_image_file_size"
    t.datetime "accred_1_image_updated_at"
    t.string   "accred_1_image_alt"
    t.string   "accred_1_link"
    t.string   "accred_2_image_file_name"
    t.string   "accred_2_image_content_type"
    t.integer  "accred_2_image_file_size"
    t.datetime "accred_2_image_updated_at"
    t.string   "accred_2_image_alt"
    t.string   "accred_2_link"
    t.string   "accred_3_image_file_name"
    t.string   "accred_3_image_content_type"
    t.integer  "accred_3_image_file_size"
    t.datetime "accred_3_image_updated_at"
    t.string   "accred_3_image_alt"
    t.string   "accred_3_link"
    t.text     "specialism_content"
    t.text     "case_successes_content"
    t.string   "team_catagory"
    t.string   "google_link"
    t.string   "twitter_link"
    t.text     "champion_bio"
  end

  create_table "team_members_testimonials", :id => false, :force => true do |t|
    t.integer "team_member_id"
    t.integer "testimonial_id"
  end

  create_table "testimonials", :force => true do |t|
    t.text     "quote"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "youtube_url"
    t.string   "video_style"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

end
