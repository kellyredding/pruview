# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pruview/version"

Gem::Specification.new do |s|
  s.name        = "kelredd-pruview"
  s.version     = Pruview::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kelly D. Redding"]
  s.email       = ["kelly@kelredd.com"]
  s.homepage    = "http://github.com/kelredd/pruview"
  s.summary     = %q{Ease generating image previews (thumbnails) of various files}
  s.description = %q{Ease generating image previews (thumbnails) of various files}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("bundler", ["~> 1.0"])
  s.add_development_dependency("test-belt", ["~> 1.0"])
  s.add_development_dependency(%q<shoulda>, [">= 2.10.0"])
  s.add_development_dependency(%q<leftright>, [">= 0.0.6"])
  s.add_development_dependency(%q<kelredd-useful>, [">= 0.4.0"])
  s.add_dependency(%q<mini_magick>, ["~> 3.0"])
  s.add_dependency(%q<flvtool2>, [">= 0"])
end
