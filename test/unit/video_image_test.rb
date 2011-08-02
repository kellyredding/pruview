require 'test/helper'

module Pruview

  class VideoImageTest < Test::Unit::TestCase
    include TestBelt
    context "A Pruview::VideoImage"
    subject { Pruview::VideoImage }

    should have_instance_method :to_jpg

    should_complain_about("converting invalid video", /^Invalid source file/) do
      Pruview::VideoImage.to_jpg(FILES['invalid video'], OUTPUT_PATH, 'file')
    end

    should_complain_about("converting invalid video formats", /not supported - file extension: .poop/) do
      Pruview::VideoImage.to_jpg(FILES['invalid format'], OUTPUT_PATH, 'file')
    end

    should_complain_about("converting with invalid output paths", /^Invalid target directory/) do
      Pruview::VideoImage.to_jpg(FILES['basic video'], INVALID_OUTPUT_PATH, 'file')
    end

    should "create a jpg version of itself" do
      @output = Pruview::VideoImage.to_jpg(FILES['basic video'], OUTPUT_PATH, 'file')
      assert File.exists?(@output)
      assert_equal '.jpg', File.extname(@output)
    end

    should "quote the source path in #build_command" do
      source = 'foo bar.jpg'
      command = Pruview::VideoImage.build_command(source, 'a', 'b', 'c')
      assert_equal 'ffmpeg -i "foo bar.jpg" a -f b -an -y c', command
    end

  end

end
