class Attachment < ActiveRecord::Base
  acts_as_attachment :url => '/uploads/:basename.:style.:extension', :path => File.expand_path(File.dirname(__FILE__) + '/uploads')
end

class Document < ActiveRecord::Base
  has_many_attached_files :model => ::Attachment
end
