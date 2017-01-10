# Author: Kris Rybak - kris.rybak@bradleydyer.com
# local:project:apache tasks
# local:project:apache tasks are run locally
# global vars:
    # :application

namespace :local do
    namespace :project do
        namespace :apache do
            task :enable do
                run_locally do
                    info "Enabling virtual host"
                    execute "sudo a2ensite #{fetch(:application)}"
                end
            end

            task :graceful do
                run_locally do
                    info "Reloading graceful apache"
                    execute "sudo service apache2 graceful"
                end
            end
        end
    end
end
