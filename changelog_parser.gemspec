# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{changelog_parser}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Lars Henrik Mai}]
  s.date = %q{2011-07-03}
  s.description = %q{ChangelogParser splits a changelog into its seperate entries and tries to detect the corresponding version number and
release date. It currently defaults to parsing the common 'wikisyntax' style, but differing formats can easily be
added. It includes the 'changelog-parser' skript for parsing a changelog file from the command line.
}
  s.email = %q{lars.mai@kontinui.de}
  s.executables = [%q{changelog-parser}]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".autotest",
    ".document",
    ".rvmrc",
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "bin/changelog-parser",
    "changelog_parser.gemspec",
    "lib/changelog_parser.rb",
    "lib/changelog_parser/entry.rb",
    "lib/changelog_parser/formats.rb",
    "lib/changelog_parser/formats/default.rb",
    "lib/changelog_parser/formats/format.rb",
    "lib/changelog_parser/formats/rails.rb",
    "lib/changelog_parser/reader.rb",
    "lib/changelog_parser/runner.rb",
    "test/fixtures/activerecord-changelog",
    "test/fixtures/minitest-history.txt",
    "test/fixtures/parslet-history.txt",
    "test/fixtures/will_paginate-changelog.rdoc",
    "test/helper.rb",
    "test/test_default.rb",
    "test/test_entry.rb",
    "test/test_rails.rb",
    "test/test_reader.rb",
    "test/test_runner.rb"
  ]
  s.homepage = %q{http://github.com/lhm/changelog_parser}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.5}
  s.summary = %q{Simple parser for changelog files}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<slop>, ["~> 1.9"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<autotest-standalone>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
    else
      s.add_dependency(%q<slop>, ["~> 1.9"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<autotest-standalone>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
    end
  else
    s.add_dependency(%q<slop>, ["~> 1.9"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<autotest-standalone>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
  end
end

