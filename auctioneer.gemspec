lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'auctioneer/version'

Gem::Specification.new do |s|
  s.name = 'auctioneer'
  s.version = Auctioneer::VERSION
  s.license = 'MIT'
  s.author = 'Jeffrey Heath Basurto'
  s.email = 'jeffreybasurto@gmail.com'
  
  s.summary = 'Provides a generic auction system.'
  s.description = 'Auctioneer provides an api to generically place auctions into .'
  s.required_ruby_version = '~> 1.8.0'
  
  s.files = Dir['lib/**/*']
end
