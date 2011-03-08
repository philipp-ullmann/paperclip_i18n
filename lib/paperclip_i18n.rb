require('paperclip_i18n/has_many_attached_files')
require('paperclip_i18n/acts_as_attachment')
require('paperclip_i18n/upload_file_validator')

ActiveRecord::Base.send(:include, PaperclipI18n::Acts::PaperclipI18n)
ActiveRecord::Base.send(:include, PaperclipI18n::Acts::Attachment)
