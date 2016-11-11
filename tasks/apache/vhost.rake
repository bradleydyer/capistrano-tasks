# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Apache tasks
# Apache tasks are run on 'web' and 'apache' roles
# global vars:
    # :stage
    # :application
# vars:
    # :app_vhosts_folder    - location of vhosts files in application
    # :apache_vhosts_folder - loaction of apache vhosts

namespace :apache do
    namespace :vhost do
        # Install application conf file
        task :install do
            on roles(:web, :apache) do
                info "Installing apache virtual host conf file"
                execute "cp #{fetch(:app_vhosts_folder)}/#{fetch(:stage)}.conf #{fetch(:apache_vhosts_folder)}/#{fetch(:application)}.conf"
            end
        end

        # Enable application conf file
        task :enable do
            on roles(:web, :apache) do
                info "Enabling virtual host"
                execute "sudo a2ensite #{fetch(:application)}"
            end
        end
    end
end
