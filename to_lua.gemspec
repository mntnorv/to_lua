lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name     = 'to_lua'
  s.version  = '0.2.1'
  s.date     = Date.today.to_s
  s.summary  = 'Serialize Ruby objects to lua tables'
  s.authors  = ['Mantas Norvaiša']
  s.email    = 'mntnorv@gmail.com'
  s.homepage = 'https://github.com/mntnorv/to_lua'
  s.license  = 'MIT'

  s.files = Dir['lib/**/*']

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', ['~> 3.2.0'])
end
