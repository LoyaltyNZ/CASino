
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'casino/version'

Gem::Specification.new do |s|
  s.name        = 'casino'
  s.version     = CASino::VERSION
  s.authors     = ['Nils Caspar', 'Raffael Schmid', 'Samuel Sieg']
  s.email       = ['ncaspar@me.com', 'raffael@yux.ch', 'samuel.sieg@me.com']
  s.homepage    = 'http://rbcas.org/'
  s.license     = 'MIT'
  s.summary     = 'A simple CAS server written in Ruby using the Rails framework.'
  s.description = 'CASino is a simple CAS (Central Authentication Service) server.'

  s.required_ruby_version = '>= 3.1'

  s.files         = Dir.glob( '{app,config,db,lib,public}/**/*.rb' ) + Dir.glob( '*.pem' )
  s.test_files    = Dir.glob( 'spec/**/*.*' )
  s.require_paths = ['lib']

  sign_file = File.expand_path '~/.gem/casino-private_key.pem'
  if File.exist?(sign_file)
    s.signing_key = sign_file
    s.cert_chain  = ['casino-public_cert.pem']
  end

  s.add_runtime_dependency 'addressable',    '~> 2.8'
  s.add_runtime_dependency 'faraday',        '~> 2.7'
  s.add_runtime_dependency 'grape',          '~> 2.1'
  s.add_runtime_dependency 'grape-entity',   '~> 1.0'
  s.add_runtime_dependency 'kaminari',       '~> 1.2'
  s.add_runtime_dependency 'rails',          '~> 7.1'
  s.add_runtime_dependency 'rotp',           '~> 3.3'
  s.add_runtime_dependency 'rqrcode_png',    '~> 0.1'
  s.add_runtime_dependency 'sass-rails',     '~> 6.0'
  s.add_runtime_dependency 'terminal-table', '~> 3.0'
  s.add_runtime_dependency 'useragent',      '~> 0.16'
  s.add_runtime_dependency 'base64'
  s.add_runtime_dependency 'observer'
end
