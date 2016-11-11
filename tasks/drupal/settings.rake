# Author: Kris Rybak - kris@krisrybak.com
# Drupal Settings tasks
# Composer tasks are run on 'web' and 'drupal' role
# global vars:
    # :shared_path
# vars:
    # :drupal_settings_file_path - location of settings file in application
    # :drupal_settings_file_name - name of settings file in application

namespace :drupal do
    namespace :settings do
        task :touch do
            on roles(:web, :drupal) do
                info "Creating empty settings.php file"
                execute :touch, "#{shared_path}/web/sites/default/settings.php"
                info "settings.php file has been created"
            end
        end

        task :install do
            on roles(:web, :drupal) do
                info "Install settings.php file"
                execute :cp, "#{fetch(:drupal_settings_file_path)}/#{fetch(:drupal_settings_file_name)} #{shared_path}/web/sites/default/settings.php"
                info "settings.php file has been installed"
            end
        end
    end
end
