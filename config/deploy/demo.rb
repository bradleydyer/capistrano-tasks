server 'demo-01-eu.bd-ns.net', user: 'deploy', roles: %w{db web files app assets}
server 'demo-02-eu.bd-ns.net', user: 'deploy', roles: %w{web}

set :branch, ENV['branch'] || 'develop'
