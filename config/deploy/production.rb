server 'web.example.com', user: 'deploy', roles: %w{db web}

set :branch, ENV['branch'] || 'master'
