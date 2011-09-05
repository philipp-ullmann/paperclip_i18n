module PaperclipI18n
  module ActsAsAttachment
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # Extends the model to afford the ability to associate other records with the receiving record.
      #
      # This module needs the paperclip plugin to work
      # http://www.thoughtbot.com/projects/paperclip
      def acts_as_attachment(options = {})
        default_options = options
        default_options[:url] = "/uploads/#{Rails.env}/assets/:id_partition/:basename.:style.:extension" if default_options[:url].blank?
        default_options[:path] = "#{Rails.root}/public/uploads/#{Rails.env}/assets/:id_partition/:basename.:style.:extension" if default_options[:path].blank?

        has_attached_file(:upload, default_options)
        belongs_to(:attachable, :polymorphic => true)
        scope(:i18ns, lambda { where(:upload_language => ::I18n.locale.to_s) })
        include(::PaperclipI18n::ActsAsAttachment::InstanceMethods)
      end
    end
    
    module InstanceMethods
      def url(*args)
        upload.url(*args)
      end

      def name
        upload_file_name
      end

      def content_type
        upload_content_type
      end

      def size
        upload_file_size
      end

      def browser_safe?
        %w(jpg gif png).include?(url.split('.').last.sub(/\?.+/, '').downcase)
      end
      alias_method(:web_safe?, :browser_safe?)

      # This method assumes you have images that corespond to the filetypes.
      # For example "image/png" becomes "image-png.png"
      def icon
        "#{upload_content_type.gsub(/[\/\.]/,'-')}.png"
      end

      def detach(attached)
        a = attachings.find(:first, :conditions => ['attachable_id = ? AND attachable_type = ?', attached, attached.class.to_s])
        raise(::ActiveRecord::RecordNotFound) unless a
        a.destroy
      end

      # Rails doc says: Using polymorphic assocs with STI can be a little tricky
      # --> read more @ http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
      def attachable_type=(sType)
        super(sType.to_s.classify.constantize.base_class.to_s)
      end
    end
  end
end