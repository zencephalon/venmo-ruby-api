Gem::Specification.new do |s|
  s.name        = 'venmo-api'
  s.version     = '0.0.2'
  s.date        = '2013-09-02'
  s.summary     = "Venmo Client API"
  s.description = "A simple wrapper for the Venmo API"
  s.authors     = ["Chris Maddern"]
  s.email       = 'chris@venmo.com'
  s.files       = ["lib/venmo-api.rb", "lib/payment.rb", "lib/user.rb"]
  s.homepage    =
    'http://www.venmo.com'
  s.license       = 'MIT'

  s.add_dependency('json', '>= 1.5.0')
end
