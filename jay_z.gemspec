# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jay_z/version"

Gem::Specification.new do |s|
  s.name        = "jay_z"
  s.version     = JayZ::VERSION
  s.authors     = ["Anders Törnqvist"]
  s.email       = ["anders.tornqvist@gmail.com"]
  s.homepage    = "https://github.com/unders/jay_z"
  s.summary     = %q{A model factory}
  s.description = %q{A model factory. Say no to fixtures.}

  s.rubyforge_project = "jay_z"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
