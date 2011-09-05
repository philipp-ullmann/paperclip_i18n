require('active_model')
require('active_record')
require('paperclip')
require('paperclip/railtie')
Paperclip::Railtie.insert
require('paperclip_i18n/has_many_attached_files')
require('paperclip_i18n/acts_as_attachment')
require('paperclip_i18n/upload_file_validator')

ActiveRecord::Base.send(:include, ::PaperclipI18n::ActsAsAttachment)
ActiveRecord::Base.send(:include, ::PaperclipI18n::HasManyAttachedFiles)
