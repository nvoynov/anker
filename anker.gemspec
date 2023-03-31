# frozen_string_literal: true

require_relative "lib/anker/version"

Gem::Specification.new do |spec|
  spec.name = "anker"
  spec.version = Anker::VERSION
  spec.authors = ["Nikolay Voynov"]
  spec.email = ["nvoynov@gmail.com"]

  spec.summary = "Anki CSV generator"
  spec.description = "Anker provides simple format for designing a set of Anki notes in plain text files, parser of the format, and Anki CSV generator. \"Basic\", \"Cloze\", and \"Basic and optionally Reversible\" notes could be written in the same single file and then transformed into a set of CSV files - one file per note type."
  spec.homepage = "https://github.com/nvoynov/anker"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
