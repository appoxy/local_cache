# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{local_cache}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Travis Reeder"]
  s.date = %q{2009-08-04}
  s.description = %q{Similar to Rails' built in MemoryStore, but adds size limit and expiration.}
  s.email = %q{travis@appoxy.com}
  s.extra_rdoc_files = [
    "README.markdown"
  ]
  s.files = [
    "lib/local_cache.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/appoxy/local_cache/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Similar to Rails' built in MemoryStore, but adds size limit and expiration.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
