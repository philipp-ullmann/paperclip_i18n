class UploadFileValidator < ActiveModel::EachValidator
  DEFAULT_OPTIONS = { :content_type => nil,
                      :less_then => nil,
                      :presence => true,
                      :skip_on_versioning => false }

  def initialize(options)
    super(options)
    @options = DEFAULT_OPTIONS.merge(@options)
  end

  def validate_each(record, attribute, value)
    return if options[:skip_on_versioning] && !record.record_timestamps # due to the versioning, which is copied through jbackend
    less_then = options[:less_then]
    content_type = options[:content_type]
    return unless options[:presence]
    record.errors[attribute] << 'must be provided' if options[:presence] and !asset_available?(record, value)
    
    if !value.nil?
      record.errors[attribute] << "must be smaller then #{less_then}" if not less_then.nil? and value.size > less_then
      record.errors[attribute] << "must be of a file valid type: #{content_type}" if not content_type.nil? and not value.content_type =~ content_type
    end
  end

  def asset_available?(record, value)
    !record.assets.i18ns.first.nil? || !value.nil?
  end
end