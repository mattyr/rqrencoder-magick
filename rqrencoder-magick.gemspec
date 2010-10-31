# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rqrencoder-magick/version"

Gem::Specification.new do |s|
  s.name        = "rqrencoder-magick"
  s.version     = RQREncoder::Magick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Robinson"]
  s.email       = ["robinson.matty@gmail.com"]
  s.homepage    = "http://github.com/mattyr/rqrencoder-magick"
  s.summary     = %q{An image file generator for QRCodes using RMagick}
  s.description = %q{An image file generator for QRCodes using RMagick}

  s.rubyforge_project = "rqrencoder-magick"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

	s.add_dependency('rqrencoder', '>= 0.1.2')
	s.add_dependency('rmagick', '>= 2.13.1')
end
