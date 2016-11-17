# Author: Kris Rybak - kris@krisrybak.com
# Drupal Settings tasks
# Drupal tasks are run on 'web' and 'drupal' role
# global vars:
    # :release_path
    # :stage
# vars:
    # :drupal_settings_file_name - name of settings file in application

namespace :drupal do
    namespace :settings do
        task :touch do
            on roles(:web, :drupal) do
                info "Creating empty settings.php file"
                execute :touch, "#{release_path}/web/sites/default/settings.php"
                info "settings.php file has been created"
            end
        end

        task :install do
            on roles(:web, :drupal) do
                info "Install settings.php file"
                if remote_file_exists?("#{release_path}/config/environment/#{fetch(:stage)}/settings/#{fetch(:drupal_settings_file_name)}")
                    invoke 'drupal:settings:install:stage'
                else
                    info "Looking for default settings.php file"
                    if remote_file_exists?("#{release_path}/config/environment/default/settings/#{fetch(:drupal_settings_file_name)}")
                        invoke 'drupal:settings:install:default'
                    end
                end
                info "settings.php file has been installed"
            end
        end
        namespace :install do
            task :stage do
                on roles(:web, :drupal) do
                    info "Installing #{fetch(:stage)} settings.php version of the file"
                    execute :cp, "#{release_path}/config/environment/#{fetch(:stage)}/settings/#{fetch(:drupal_settings_file_name)} #{release_path}/web/sites/default/settings.php"
                end
            end

            task :default do
                on roles(:web, :drupal) do
                    info "Installing default settings.php version of the file"
                    execute :cp, "#{release_path}/config/environment/default/settings/#{fetch(:drupal_settings_file_name)} #{release_path}/web/sites/default/settings.php"
                end
            end
        end
    end
end
