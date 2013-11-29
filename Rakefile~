require "bundler/gem_tasks"

task :default => :rspec

desc "Ejecuta Rspec"
task :rspec do
   sh "rspec -Ilib spec/matrixfamily_spec.rb"
end

desc "Ejecuta las espectativas"
task :test do
   sh "ruby test/tc_matrixfamily.rb"
end
