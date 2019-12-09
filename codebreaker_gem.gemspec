lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codebreaker_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'codebreaker_gem'
  spec.version       = CodebreakerGem::VERSION
  spec.authors       = ['GorohovAlex']
  spec.email         = ['gorochov.as@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/GorohovAlex/codebreaker_gem'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'fasterer', '~> 0.8.0'
  spec.add_development_dependency 'rake', '~> 12.3.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov' # , require: false, group: :test
end
