# Author: Kris Rybak - kris@krisrybak.com
# Composer tasks
# Composer tasks are run on 'web' and 'composer' role
# global vars:
    # :release_path

namespace :composer do
    namespace :installer do
        task :install do
            on roles(:web, :composer) do
                info "Running composer install"
                execute " cd #{release_path} && composer install"
                info "Composer install done"
            end
        end

        task :update do
            on roles(:web, :composer) do
                info "Running composer update"
                execute " cd #{release_path} && composer update"
                info "Composer update done"
            end
        end
    end
end
