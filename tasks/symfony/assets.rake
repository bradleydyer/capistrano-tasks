# Author: Anton McCook
# Symfony assets tasks
# Symfony assets tasks are run on 'web' and 'symfony' role
# global vars:
    # :release_path
    # :stage

namespace :symfony do
    namespace :assets do
        task :install do
            on roles(:web, :symfony) do
                info "Running bin/console assets:install"
                execute "cd #{release_path} && php bin/console assets:install --env=prod"
                info "Assets installed"
            end
        end

        task :dump do
            on roles(:web, :symfony) do
                info "Running bin/console assetic:dump"
                execute "cd #{release_path} && php bin/console assetic:dump --env=prod"
                info "Assets dumped"
            end
        end
    end
end
