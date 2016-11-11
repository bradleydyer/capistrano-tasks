# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Htaccess tasks
# Htaccess tasks are run on 'web' and 'htaccess' roles
# global vars:
    # :release_path
    # :stage
# vars:
    # :app_httpdocs_folder  - application web files folder

namespace :htaccess do
    task :install do
        on roles(:web, :htaccess) do
            info "Installing htaccess file"
            if remote_file_exists?("#{release_path}/config/environment/#{fetch(:stage)}/htaccess/.htaccess")
                invoke 'htaccess:install:stage'
            else
                info "Looking for default htaccess file"
                if remote_file_exists?("#{release_path}/config/environment/default/htaccess/.htaccess")
                    invoke 'htaccess:install:default'
                else
                    info "No .htaccess file has been found"
                end
            end

            info ".htaccess file has been installed"
        end
    end

    namespace :install do
        # Install stage htaccess
        task :stage do
            on roles(:web, :htaccess) do
                info "Installing stage .htaccess file"
                execute "cp #{release_path}/config/environment/#{fetch(:stage)}/htaccess/.htaccess #{fetch(:app_httpdocs_folder)}/.htaccess"
            end
        end

        # Install default htaccess
        task :default do
            on roles(:web, :htaccess) do
                info "Installing default .htaccess file"
                execute "cp #{release_path}/config/environment/default/htaccess/.htaccess #{fetch(:app_httpdocs_folder)}/.htaccess"
            end
        end
    end
end
