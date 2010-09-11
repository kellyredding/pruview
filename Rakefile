require 'rubygems'
require 'rake/gempackagetask'
require 'simple_gem/testtasks'

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

  s.add_development_dependency("shoulda", [">= 2.10.0"])
  s.add_development_dependency("leftright", [">= 0.0.6"])
  s.add_development_dependency("kelredd-useful", [">= 0.4.0"])
  s.add_development_dependency("kelredd-simple-gem", [">= 0.7.0"])

  s.add_dependency('mini_magick')
  s.add_dependency('flvtool2')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

SimpleGem::TestTasks.new

desc 'Generate the gemspec for this gem'
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end

task :default => :gem

