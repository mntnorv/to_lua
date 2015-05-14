lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name     = 'to_lua'
  s.version  = '0.0.1'
  s.date     = '2015-05-14'
  s.summary  = 'Serialize objects to lua tables'
  s.authors  = ['Mantas Norvaiša']
  s.email    = 'mntnorv@gmail.com'
  s.files    = ['lib/hola.rb']
  s.homepage = 'https://github.com/mntnorv/to_lua'
  s.license  = 'MIT'

  spec.files = Dir['lib/**/*']
end
