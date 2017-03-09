# Author: Kris Rybak
# Symfony doctrine tasks
# Symfony doctrine tasks are run on 'db' and 'doctrine' role
# global vars:
    # :release_path

namespace :symfony do
    namespace :doctrine do
        namespace :migrations do
            task :migrate do
                on roles(:db, :doctrine) do
                    info "Running bin/console doctrine:migrations:migrate"
                    execute "cd #{release_path} && php bin/console doctrine:migrations:migrate"
                    info "Database migrated to the latest version"
                end
            end
        end
    end
end
