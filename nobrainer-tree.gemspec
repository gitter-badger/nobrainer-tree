Gem::Specification.new do |s|
  s.name          = 'nobrainer-tree'
  s.version       = '0.0.2'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Benedikt Deicke', 'Steven Eksteen']
  s.email         = ['benedikt@synatic.net','steven@secondimpression.net']
  s.homepage      = 'https://github.com/secondimpression/nobrainer-tree'
  s.summary       = 'A tree structure for NoBrainer documents'
  s.description   = 'A tree structure for NoBrainer documents using the materialized path pattern'

  s.license       = 'MIT'

  s.files         = Dir.glob('{lib,spec}/**/*') + %w(LICENSE README.md Rakefile Gemfile .rspec)

  s.add_runtime_dependency('nobrainer')
  s.add_development_dependency('rake', ['>= 0.9.2'])
  s.add_development_dependency('rspec', ['~> 3.0'])
  s.add_development_dependency('yard', ['~> 0.8'])
end
