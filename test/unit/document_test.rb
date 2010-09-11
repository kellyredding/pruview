require 'test/helper'

module Pruview
  class DocumentTest < Test::Unit::TestCase

    context "A Pruview::Document" do
      setup { @file = Pruview::Document.new(FILES['basic image'], OUTPUT_PATH) }
      subject { @file }

      should_have_instance_methods :to_jpg

      should_complain_about("converting invalid images", /^Invalid source file/) do
        Pruview::Document.new(FILES['invalid image'], OUTPUT_PATH)
      end
      should_complain_about("converting invalid image formats", /not supported - file extension: .poop/) do
        Pruview::Document.new(FILES['invalid format'], OUTPUT_PATH)
      end
      should_complain_about("converting with invalid output paths", /^Invalid target directory/) do
        Pruview::Document.new(FILES['basic image'], INVALID_OUTPUT_PATH)
      end

      should "create a jpg version of itself" do
        @output = @file.to_jpg('file', 50, 50)
        assert File.exists?(@output)
        assert_equal '.jpg', File.extname(@output)
      end

    end

  end
end