class PaperclipI18nTables < ActiveRecord::Migration
  def self.up
    create_table('assets') do |t|
      t.string('attachable_type')
      t.integer('attachable_id')
      t.string('upload_file_name')
      t.string('upload_content_type')
      t.integer('upload_file_size')
      t.string('upload_language', :limit => 6, :default => 'en')
      t.datetime('created_at')
      t.datetime('updated_at')
      t.datetime('upload_updated_at')
    end

    add_index('assets', ['attachable_id', 'attachable_type'], :name => 'index_assets_on_attachable_id_and_type')
  end

  def self.down
    drop_table(:assets)
  end
end
