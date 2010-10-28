# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{kelredd-pruview}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kelly Redding"]
  s.date = %q{2010-10-28}
  s.email = %q{kelly@kelredd.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "bin/ffyml", "lib/pruview", "lib/pruview/document.rb", "lib/pruview/exceptions.rb", "lib/pruview/sRGB.icm", "lib/pruview/USWebCoatedSWOP.icc", "lib/pruview/version.rb", "lib/pruview/video.rb", "lib/pruview/video_image.rb", "lib/pruview.rb", "test/files", "test/files/basic.jpg", "test/files/basic.mpg", "test/files/error.jpg", "test/files/error.mov", "test/files/image.tiff", "test/files/invalid_format.poop", "test/helper.rb", "test/unit", "test/unit/document_test.rb", "test/unit/video_image_test.rb", "test/unit/video_test.rb"]
  s.homepage = %q{http://github.com/kelredd/pruview}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A gem to ease generating image previews (thumbnails) of various files}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 2.10.0"])
      s.add_development_dependency(%q<leftright>, [">= 0.0.6"])
      s.add_development_dependency(%q<kelredd-useful>, [">= 0.4.0"])
      s.add_development_dependency(%q<kelredd-simple-gem>, [">= 0.7.0"])
      s.add_runtime_dependency(%q<mini_magick>, ["~> 3.0"])
      s.add_runtime_dependency(%q<flvtool2>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, [">= 2.10.0"])
      s.add_dependency(%q<leftright>, [">= 0.0.6"])
      s.add_dependency(%q<kelredd-useful>, [">= 0.4.0"])
      s.add_dependency(%q<kelredd-simple-gem>, [">= 0.7.0"])
      s.add_dependency(%q<mini_magick>, ["~> 3.0"])
      s.add_dependency(%q<flvtool2>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 2.10.0"])
    s.add_dependency(%q<leftright>, [">= 0.0.6"])
    s.add_dependency(%q<kelredd-useful>, [">= 0.4.0"])
    s.add_dependency(%q<kelredd-simple-gem>, [">= 0.7.0"])
    s.add_dependency(%q<mini_magick>, ["~> 3.0"])
    s.add_dependency(%q<flvtool2>, [">= 0"])
  end
end
