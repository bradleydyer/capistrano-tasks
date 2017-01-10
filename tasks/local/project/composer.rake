# Author: Kris Rybak - kris.rybak@bradleydyer.com
# local:project:composer tasks
# local:project:composer tasks are run locally
# global vars:
    # :application

namespace :local do
    namespace :project do
        namespace :composer do
            task :install do
                run_locally do
                    info "Install dependencies"
                    execute "composer install"
                end
            end
        end
    end
end
