require 'test_belt'

# Add test and lib paths to the $LOAD_PATH
[ File.dirname(__FILE__),
  File.join(File.dirname(__FILE__), '..', 'lib')
].each do |path|
  full_path = File.expand_path(path)
  $LOAD_PATH.unshift(full_path) unless $LOAD_PATH.include?(full_path)
end

require 'pruview'

FILES_PATH = "./test/files"
OUTPUT_PATH = "./test_output"
INVALID_OUTPUT_PATH = "./test_output/invalid"
FILES = {
  'basic image'    => "./test/files/basic.jpg",
  'invalid image'  => "./test/files/invalid.jpg",
  'error image'    => "./test/files/error.jpg",
  'basic video'    => "./test/files/basic.mpg",
  'invalid video'  => "./test/files/invalid.mov",
  'error video'    => "./test/files/error.mov",
  'invalid format' => "./test/files/invalid_format.poop",
  'tiff'           => "./test/files/image.tiff"
}

FileUtils.mkdir_p File.expand_path(FILES_PATH) unless File.exists? File.expand_path(FILES_PATH)
FileUtils.mkdir_p File.expand_path(OUTPUT_PATH) unless File.exists? File.expand_path(OUTPUT_PATH)

def should_complain_about(should_statement, message_match, &block)
  should "complain about #{should_statement}" do
    assert_raises Pruview::Exceptions::InvalidError do
      block.call
    end
    begin
      block.call
    rescue Exception => err
      assert_match message_match, err.message
    end
  end
end
