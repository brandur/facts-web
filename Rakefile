require "bundler/setup"
Bundler.require

require "rake/testtask"

$: << "lib"
require "facts"

Rake::TestTask.new do |t|
  t.libs.push "lib", "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end