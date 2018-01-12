# Author: Kris Rybak - kris.rybak@rybakdigital.com
# Npm Tasks
# Npm tasks are run on 'web' and 'npm' role
# global vars:
    # :release_path

    namespace :npm do
        namespace :installer do
            task :install do
                on roles(:web, :npm) do
                    info "Running npm install"
                    execute "cd #{release_path} && npm install"
                    info "npm install done"
                end
            end
        end
    end
    