require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/pruview/version'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name             = 'kelredd-pruview'
  s.version          = Pruview::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.rdoc)
  s.rdoc_options     = %w(--main README.rdoc)
  s.summary          = "A gem to ease generating image previews (thumbnails) of various files"
  s.author           = 'Kelly Redding'
  s.email            = 'kelly@kelredd.com'
  s.homepage         = 'http://github.com/kelredd/pruview'
  s.files            = %w(README.rdoc Rakefile) + Dir.glob("{bin,features,lib,test}/**/*")
  # s.executables    = ['pruview']
  
  s.add_dependency('mini_magick')
  s.add_dependency('flvtool2')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

desc 'Generate the gemspec to serve this Gem from Github'
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end