# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Apache tasks
# Apache tasks are run on 'web' and 'apache' roles
# global vars:
    # :release_path
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
                info "Looking for apache virtual host file"
                if remote_file_exists?("#{release_path}/config/environment/#{fetch(:stage)}/vhosts/vhost.conf")
                    info "#{fetch(:stage)} vhost conf file found!"
                    invoke 'apache:vhost:install:stage'
                    info "Virtual host conf file has been installed"
                elsif remote_file_exists?("#{release_path}/config/environment/default/vhosts/vhost.conf")
                    info "default vhost conf file found!"
                    invoke 'apache:vhost:install:default'
                    info "Virtual host conf file has been installed"
                else
                    info "No virtual host file found."
                end
            end
        end

        namespace :install do
            # Install stage vhost
            task :stage do
                on roles(:web, :apache) do
                    info "Installing stage vhost"
                    execute "cp #{release_path}/config/environment/#{fetch(:stage)}/vhosts/vhost.conf #{fetch(:apache_vhosts_folder)}/#{fetch(:application)}.conf"
                end
            end

            # Install default vhost
            task :default do
                on roles(:web, :apache) do
                    info "Installing default vhost"
                    execute "cp #{release_path}/config/environment/default/vhosts/vhost.conf #{fetch(:apache_vhosts_folder)}/#{fetch(:application)}.conf"
                end
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
