require 'bundler/gem_tasks'

require 'rake/testtask'
require 'minitest/spec'

Rake::TestTask.new(:spec) do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

task :test => :spec
task :default => :test

desc  "open console (require 'jay_z')"
task :c do
  system "irb -I lib -r jay_z"
end
