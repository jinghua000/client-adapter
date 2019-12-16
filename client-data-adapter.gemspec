lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require_relative 'lib/client-data-adapter/version'

Gem::Specification.new do |s|

  s.name = 'client-data-adapter'
  s.version = ClientDataAdapter::VERSION
  s.summary = 'client data adapter'
  s.description = 'For unify data formats to transfer to clients.'
  s.authors = ['shadow']
  s.files = `git ls-files`.split("\n")
  s.homepage = 'https://github.com/jinghua000/client-data-adapter'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.1'

end