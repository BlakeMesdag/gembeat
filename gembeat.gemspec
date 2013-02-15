# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gembeat/version'

Gem::Specification.new do |gem|
  gem.name          = "gembeat"
  gem.version       = Gembeat::VERSION
  gem.authors       = ["Blake Mesdag"]
  gem.email         = ["blakemesdag@gmail.com"]
  gem.description   = "A gem for enabling you to publish your apps gems on deploy to a central server"
  gem.summary       = "Enables you to send a pulse to a gembeat server for tracking all your gems"
  gem.homepage      = "http://github.com/BlakeMesdag/gembeat"

  gem.extra_rdoc_files = [
    "README.md"
  ]

  gem.files         = [
    ".gitignore",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "gembeat.gemspec",
    "data/ca-certificates.crt",
    "lib/gembeat.rb",
    "lib/gembeat/version.rb"
  ]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
