server 'web-04-eu.bd-ns.net', user: 'deploy', roles: %w{db web assets app}
server 'web-05-eu.bd-ns.net', user: 'deploy', roles: %w{web}
server 'web-06-eu.bd-ns.net', user: 'deploy', roles: %w{web}
server 'web-07-eu.bd-ns.net', user: 'deploy', roles: %w{web}

set :branch, ENV['branch'] || 'master'
