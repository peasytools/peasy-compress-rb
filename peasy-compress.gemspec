# frozen_string_literal: true

require_relative "lib/peasy_compress/version"

Gem::Specification.new do |s|
  s.name        = "peasy-compress"
  s.version     = PeasyCompress::VERSION
  s.summary     = "Compression — gzip, deflate, brotli"
  s.description = "Compression library for Ruby — gzip, deflate, and zlib compression with ratio calculation. Uses Ruby stdlib Zlib, zero external dependencies."
  s.authors     = ["PeasyTools"]
  s.email       = ["hello@peasytools.com"]
  s.homepage    = "https://peasytools.com"
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"

  s.files = Dir["lib/**/*.rb"]

  s.metadata = {
    "homepage_uri"      => "https://peasytools.com",
    "source_code_uri"   => "https://github.com/peasytools/peasy-compress-rb",
    "changelog_uri"     => "https://github.com/peasytools/peasy-compress-rb/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://peasytools.com",
    "bug_tracker_uri"   => "https://github.com/peasytools/peasy-compress-rb/issues",
  }
end
