# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kelredd-pruview}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kelly Redding"]
  s.date = %q{2010-01-21}
  s.email = %q{kelly@kelredd.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "features/document.feature", "features/step_definitions", "features/step_definitions/common_steps.rb", "features/step_definitions/document_steps.rb", "features/step_definitions/support", "features/step_definitions/support/env.rb", "features/step_definitions/support/helpers.rb", "features/step_definitions/video_image_steps.rb", "features/step_definitions/video_steps.rb", "features/video.feature", "features/video_image.feature", "lib/pruview", "lib/pruview/document.rb", "lib/pruview/exceptions.rb", "lib/pruview/sRGB.icm", "lib/pruview/USWebCoatedSWOP.icc", "lib/pruview/version.rb", "lib/pruview/video.rb", "lib/pruview/video_image.rb", "lib/pruview.rb", "test/files", "test/files/basic.jpg", "test/files/basic.mpg", "test/files/error.jpg", "test/files/error.mov", "test/files/invalid_format.poop", "test/test_helper.rb", "test/unit", "test/unit/pruview_test.rb"]
  s.homepage = %q{http://github.com/kelredd/pruview}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A gem to ease generating image previews (thumbnails) of various files}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

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
