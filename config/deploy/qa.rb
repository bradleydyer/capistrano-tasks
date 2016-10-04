server 'qa-01-eu.bd-ns.net', user: 'deploy', roles: %w{db web files app assets}

set :branch, ENV['branch'] || 'develop'
