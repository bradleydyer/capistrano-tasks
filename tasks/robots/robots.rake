# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Robots tasks
# Robots tasks are run on 'web' and 'robots' roles
# global vars:
    # :release_path
    # :stage
# vars:
    # :app_httpdocs_folder  - application web files folder

namespace :robots do
    task :install do
        on roles(:web, :robots) do
            info "Installing robots file"
            if remote_file_exists?("#{release_path}/config/environment/#{fetch(:stage)}/robots/robots.txt")
                invoke 'robots:install:stage'
            else
                info "Looking for default robots file"
                if remote_file_exists?("#{release_path}/config/environment/default/robots/robots.txt")
                    invoke 'robots:install:default'
                else
                    info "No robots.txt file has been found"
                end
            end

            info "robots.txt file has been installed"
        end
    end

    namespace :install do
        # Install stage robots
        task :stage do
            on roles(:web, :robots) do
                info "Installing stage robots file"
                execute "cp #{release_path}/config/environment/#{fetch(:stage)}/robots/robots.txt #{release_path}/#{fetch(:app_httpdocs_folder)}/robots.txt"
            end
        end

        # Install default robots
        task :default do
            on roles(:web, :robots) do
                info "Installing default robots file"
                execute "cp #{release_path}/config/environment/default/robots/robots.robots #{release_path}/#{fetch(:app_httpdocs_folder)}/robots.txt"
            end
        end
    end
end
