# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "audited_notifications"
  gem.homepage = "http://github.com/frimik/audited_notifications"
  gem.license = "GPL-3"
  gem.summary = %Q{Audit notification plugin engine for Foreman}
  gem.description = %Q{Does Email and IRC notifications of all Audit events from TheForeman}
  gem.email = "frimik@gmail.com"
  gem.authors = ["Mikael Fridh"]
  # dependencies defined in Gemfile
end

task :default => :test
