require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = FileList['test/**/*_test.rb']
  t.warning = false
end

task default: %w(test)
