lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|

  s.name = 'client-data-adapter'
  s.version = '0.1.0-beta.0'
  s.date = '2019-11-11'
  s.summary = 'client data adapter'
  s.description = 'Unifying data format for client.'
  s.authors = ['shadow']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/jinghua000/client-data-adapter'
  s.license = 'MIT'

end