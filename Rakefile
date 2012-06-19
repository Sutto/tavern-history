#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => :spec
desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new :spec