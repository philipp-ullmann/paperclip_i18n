require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/models')

describe PaperclipI18n do
  describe "has_many_attached_files" do
    before :each do
      I18n.locale = :en
      @file = File.new(File.dirname(__FILE__) + "/upload_dummy.txt")
      @doc = Document.new
      @doc.upload = @file
      @doc.save
    end
    it('should read the file name properly') do
      @doc.assets.i18ns.first.name.should == File.basename('upload_dummy.txt')
    end
    it('should store the file size properly') do
      @doc.assets.i18ns.first.size.should == @file.size
    end

    context("default language german") do
      before :each do
        @file_german = File.new(File.dirname(__FILE__)+"/upload_dummy.txt")
        I18n.locale = :de
        @doc.upload = @file_german
        @doc.save
        @doc.assets.reload
      end
      it('should have one english upload') do
        I18n.locale = :en
        @doc.assets.i18ns.count == 1
      end
      it('should have one german upload') do
        @doc.assets.i18ns.count == 1
      end
      it('should have 2 uploads in total') do
        @doc.assets.count == 2
      end
    end
  end
end