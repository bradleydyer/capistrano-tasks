# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Apache tasks
# Apache tasks are run on 'web' and 'apache' roles
# global vars:
    # :stage
    # :application
# vars:
    # :app_vhosts_folder    - location of vhosts files in application
    # :apache_vhosts_folder - loaction of apache vhosts

namespace :apache_service do
    # Reload graceful apache
    task :graceful do
        on roles(:web, :apache) do
            info "Reloading graceful apache"
            execute "sudo service apache2 graceful"
        end
    end
end
