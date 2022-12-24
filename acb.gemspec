# frozen_string_literal: true

require_relative 'lib/acb/version'

Gem::Specification.new do |spec|
  spec.name = 'acb'
  spec.version = Acb::VERSION
  spec.authors = ['Akito Hikasa']
  spec.email = ['wetsand.wfs@gmail.com']

  spec.summary = %(ActiveRecord CSV Builder)
  spec.description = %(ActiveRecord CSV Builder)
  spec.homepage = 'https://github.com/kakubin/acb'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = 'TODO: Put your gem's CHANGELOG.md URL here.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 6.0.0'

  spec.add_development_dependency 'activerecord', '>= 6.0.0'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'sqlite3'
end
