require 'test/unit/assertions'
World(Test::Unit::Assertions)

require File.dirname(__FILE__) + '/../../../lib/pruview'

FILES_PATH = "./test/files"
OUTPUT_PATH = "./test_output"
INVALID_OUTPUT_PATH = "./test_output/invalid"
FILES = {
  'basic image' => "./test/files/basic.jpg",
  'invalid image' => "./test/files/invalid.jpg",
  'error image' => "./test/files/error.jpg",
  'basic video' => "./test/files/basic.mpg",
  'invalid video' => "./test/files/invalid.mov",
  'error video' => "./test/files/error.mov",
  'invalid format' => "./test/files/invalid_format.poop"
}

FileUtils.mkdir_p File.expand_path(FILES_PATH) unless File.exists? File.expand_path(FILES_PATH)
FileUtils.mkdir_p File.expand_path(OUTPUT_PATH) unless File.exists? File.expand_path(OUTPUT_PATH)