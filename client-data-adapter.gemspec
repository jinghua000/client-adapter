lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|

  s.name = 'client-data-adapter'
  s.version = '0.1.0'
  s.summary = 'client data adapter'
  s.description = 'For unify data formats to transfer to clients.'
  s.authors = ['shadow']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/jinghua000/client-data-adapter'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.1'

end