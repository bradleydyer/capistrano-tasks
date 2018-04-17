# Author: Kris Rybak - kris@krisrybak.com
# Wordpress Settings tasks
# Wordpress tasks are run on 'web' and 'wordpress' role
# global vars:
    # :release_path
    # :stage
# vars:
    # :wordpress_config_file_name - name of config file in application
set :wordpress_settings_files_folder, "web"

namespace :wordpress do
    namespace :settings do
        task :install do
            on roles(:web, :wordpress) do
                info "Install wp-config.php file"
                if remote_file_exists?("#{release_path}/config/environment/#{fetch(:stage)}/settings/#{fetch(:wordpress_config_file_name)}")
                    invoke 'wordpress:settings:install:stage'
                else
                    info "Looking for default settings.php file"
                    if remote_file_exists?("#{release_path}/config/environment/default/settings/#{fetch(:wordpress_config_file_name)}")
                        invoke 'wordpress:settings:install:default'
                    end
                end
                info "wp-config.php file has been installed"
            end
        end
        namespace :install do
            task :stage do
                on roles(:web, :wordpress) do
                    info "Installing #{fetch(:stage)} wp-config.php version of the file"
                    execute :cp, "#{release_path}/config/environment/#{fetch(:stage)}/settings/#{fetch(:wordpress_config_file_name)} #{release_path}/#{fetch(:wordpress_settings_files_folder)}/wp-config.php"
                end
            end

            task :default do
                on roles(:web, :wordpress) do
                    info "Installing default wp-config.php version of the file"
                    execute :cp, "#{release_path}/config/environment/default/settings/#{fetch(:wordpress_config_file_name)} #{release_path}/#{fetch(:wordpress_settings_files_folder)}/wp-config.php"
                end
            end
        end
    end
end
