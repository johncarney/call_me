# frozen_string_literal: true

require_relative "lib/call_me/version"

Gem::Specification.new do |spec|
  spec.name    = "call_me"
  spec.version = CallMe::VERSION
  spec.authors = ["John Carney"]
  spec.email   = ["john@carney.id.au"]

  spec.summary     = "Simple module for implementing the Service Object pattern with customisable verbs."
  spec.description = "Simple module for implementing the Service Object pattern with customisable verbs."
  spec.homepage    = "https://github.com/johncarney/call_me.git"
  spec.license     = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "https://github.com/johncarney/call_me/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "bin"
  spec.executables   = []
  spec.require_paths = ["lib"]
end
