# -*- ruby -*-

require 'rubygems'
require './lib/local_cache.rb'

begin
    require 'jeweler'
    Jeweler::Tasks.new do |gemspec|
        gemspec.name = "local_cache"
        gemspec.summary = "Similar to Rails' built in MemoryStore, but adds size limit and expiration."
        gemspec.email = "travis@appoxy.com"
        gemspec.homepage = "http://github.com/appoxy/local_cache/"
        gemspec.description = "Similar to Rails' built in MemoryStore, but adds size limit and expiration."
        gemspec.authors = ["Travis Reeder"]
        gemspec.files = FileList['lib/**/*.rb']
    end
rescue LoadError
    puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

# vim: syntax=Ruby
