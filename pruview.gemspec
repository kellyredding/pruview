# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pruview}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kelly Redding"]
  s.date = %q{2009-07-21}
  s.email = %q{kelly@kelredd.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/pruview", "lib/pruview/document.rb", "lib/pruview/sRGB.icm", "lib/pruview/USWebCoatedSWOP.icc", "lib/pruview/version.rb", "lib/pruview/video.rb", "lib/pruview.rb", "test/test_helper.rb", "test/unit", "test/unit/pruview_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A gem to ease generating image previews (thumbnails) of various files}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>, [">= 0"])
      s.add_runtime_dependency(%q<flvtool2>, [">= 0"])
    else
      s.add_dependency(%q<mini_magick>, [">= 0"])
      s.add_dependency(%q<flvtool2>, [">= 0"])
    end
  else
    s.add_dependency(%q<mini_magick>, [">= 0"])
    s.add_dependency(%q<flvtool2>, [">= 0"])
  end
end
