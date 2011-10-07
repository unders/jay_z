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
  s.add_development_dependency "activerecord", "~> 3.1.0"
  s.add_development_dependency "railties", "~> 3.1.0"
  s.add_development_dependency "sqlite3", "~> 1.3.4"

  example_files   = `git ls-files -- example`.split("\n")
  no_gem_files    = example_files + %w[.gitignore .rvmrc]
  s.files         = `git ls-files`.split("\n") - no_gem_files
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
                      File.basename(f)
                    end
  s.require_paths = ["lib"]
end
