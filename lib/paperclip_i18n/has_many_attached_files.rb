module PaperclipI18n
  module HasManyAttachedFiles
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Extends the model to afford the ability to associate other records with the receiving record.
      #
      # This module needs the paperclip plugin to work
      # http://www.thoughtbot.com/projects/paperclip
      def has_many_attached_files(options = {})
        class_attribute(:has_many_attached_files_options)
        self.has_many_attached_files_options = { :counter_cache => options[:counter_cache], :styles => options[:styles], :model => options[:model] ||= ::Asset }
        
        attr_accessor(:upload)
        attr_accessor(:current_file_language)
        after_save(:save_attached_files)
        has_many(:assets, :as => :attachable, :dependent => :destroy, :class_name => self.has_many_attached_files_options[:model].to_s)
        include(::PaperclipI18n::HasManyAttachedFiles::InstanceMethods)
      end
    end
    
    module InstanceMethods
      def save_attached_files
        self.has_many_attached_files_options[:model].transaction do
          if upload.is_a?(Array)
            upload.each do |data_item|
              create_or_update_asset(data_item) unless data_item.nil? || data_item.blank?
            end
          else
            create_or_update_asset(upload)
          end
        end unless upload.nil? || upload.blank?
      end

      def create_or_update_asset(data_item)
        override_default_styles, normalised_styles = override_default_styles?(data_item.original_filename)
        asset = assets.where(:upload_language => current_language).first || self.has_many_attached_files_options[:model].new # is there an attachment, then delete the old
        asset.upload.instance_variable_set('@styles', normalised_styles) if override_default_styles
        asset.upload = data_item
        asset.upload_language = current_language

        if asset.new_record?
          asset.save
          assets << asset # store the asset ...
        else
          asset.save
        end
        assets(true) # reload implicitly
      end

      def override_default_styles?(filename)
        if !self.has_many_attached_files_options[:styles].nil?
          normalised_styles = {}
          
          self.has_many_attached_files_options[:styles].each do |name, args|
            dimensions, format = [args, nil].flatten[0..1]
            format = nil if format.blank?
            
            if filename.match(/\.pdf$/) # remove crop commands if file is a PDF (this fails with Imagemagick)
              args.gsub!(/#/ , '')
              format = 'png'
            end
            
            normalised_styles[name] = { :processors => [:thumbnail], :geometry => dimensions, :format => format }
          end
          
          return true, normalised_styles
        else
          return(false)
        end
      end
      
      # based on the Authlogic plugin (http://agilewebdevelopment.com/plugins/authgasm)
      def current_language
        @current_file_language || ::I18n.locale.to_s
      end
    end
  end
end
