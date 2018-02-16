 Gem::Specification.new do |s|
   s.name          = 'kele_wyll'
   s.version       = '0.0.1'
   s.date          = '2017-11-13'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Bloc API'
   s.authors       = ['Natalie Wyll']
   s.email         = 'nataliewyll@yahoo.com'
   s.files         = ['lib/kele_wyll.rb', 'lib/roadmap.rb']
   s.require_paths = ["lib"]
   s.homepage      =
     'http://rubygems.org/gems/kele_wyll'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
   s.add_runtime_dependency 'json', '~> 2.1'
 end
