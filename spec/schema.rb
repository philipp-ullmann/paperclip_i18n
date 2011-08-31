ActiveRecord::Schema.define do
  create_table "attachments", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "upload_file_name"
    t.integer  "upload_content_type"
    t.datetime "upload_file_size"
    t.datetime "upload_updated_at"
    t.string   "upload_language"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
  end
end
