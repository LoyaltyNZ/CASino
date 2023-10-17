#!/usr/bin/env rake
require 'bundler'
require 'rake'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task default: :spec

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc 'Check if latest version in CHANGELOG.md matches with current version number'
task :check_version do
  changelog = File.join(File.dirname(__FILE__), 'CHANGELOG.md')
  raise "missing CHANGELOG.md" unless File.exist?(changelog)

  if File.read(changelog).match(/[0-9]+\.[0-9]+\.[0-9]+/)[0] != CASino::VERSION
    raise "Latest version in CHANGELOG.md does not match CASino::VERSION"
  end
end
