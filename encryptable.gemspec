# frozen_string_literal: true

require_relative "lib/encryptable/version"

Gem::Specification.new do |spec|
  spec.name = "encryptable"
  spec.version = Encryptable::VERSION
  spec.authors = ["raketbizdev"]
  spec.email = ["radon1284@yahoo.com"]

  spec.summary = "A simple encryption and decryption library for Ruby  and Ruby on Rails applications."
  spec.description = "Encryptable is a lightweight and versatile Ruby gem crafted to provide seamless encryption and decryption functionalities. Whether you're building a standalone Ruby application or a Rails-powered web service, Encryptable allows you to maintain the confidentiality of your data with ease."
  spec.homepage = "https://github.com/raketbizdev/encryptable" # Replace with your actual repository URL
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org" # Default RubyGems server
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/raketbizdev/encryptable" # Replace with your actual repository URL
  spec.metadata["changelog_uri"] = "https://github.com/raketbizdev/encryptable/blob/main/CHANGELOG.md" # If you maintain a CHANGELOG.md file

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
