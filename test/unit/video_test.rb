require 'test/helper'

module Pruview

  class VideoTest < Test::Unit::TestCase
    include TestBelt

    context "A Pruview::Video"
    setup { @file = Pruview::Video.new(FILES['basic video'], OUTPUT_PATH) }
    subject { @file }

    should have_instance_methods :to_flv, :to_mov, :to_jpg, :info

    should_complain_about("converting invalid video", /^Invalid source file/) do
      Pruview::Video.new(FILES['invalid video'], OUTPUT_PATH)
    end

    should_complain_about("converting invalid video formats", /not supported - file extension: .poop/) do
      Pruview::Video.new(FILES['invalid format'], OUTPUT_PATH)
    end

    should_complain_about("converting with invalid output paths", /^Invalid target directory/) do
      Pruview::Video.new(FILES['basic video'], INVALID_OUTPUT_PATH)
    end

    should "create a mov version of itself" do
      @output = @file.to_mov('file', 50, 50)
      assert File.exists?(@output)
      assert_equal '.mov', File.extname(@output)
    end

    # too unstable to test right now
    # the above test validates the plumbing and command building
    #should "create an flv version of itself" do
    #  @output = @file.to_flv('file', 50, 50)
    #  assert File.exists?(@output)
    #  assert_equal '.flv', File.extname(@output)
    #end

    should "create a jpg version of itself" do
      @output = @file.to_jpg('file')
      assert File.exists?(@output)
      assert_equal '.jpg', File.extname(@output)
    end

    should "quote the source and yml_path args to the ffyml command" do
      command = @file.send(:info_command, 'foo bar.jpg', 'foo bar.yml')
      assert_equal %Q{#{Pruview::Video::FFYML} "foo bar.jpg" "foo bar.yml"}, command
    end

  end

end
