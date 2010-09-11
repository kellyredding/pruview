require 'test/helper'

class DocumentTest < Test::Unit::TestCase

  context "A Pruview::Document" do
    setup { @file = Pruview::Document.new(FILES['basic image'], OUTPUT_PATH) }

    should_complain_about(Pruview::Document, 'invalid image', OUTPUT_PATH, /^Invalid source file/)
    should_complain_about(Pruview::Document, 'invalid format', OUTPUT_PATH, /not supported - file extension: .poop/)
    should_complain_about(Pruview::Document, 'basic image', INVALID_OUTPUT_PATH, /^Invalid target directory/)

    should "create a jpg version of itself" do
      @output = @file.send("to_jpg", 'file', 50, 50)
      assert File.exists?(@output)
      assert_equal '.jpg', File.extname(@output)
    end

  end

end