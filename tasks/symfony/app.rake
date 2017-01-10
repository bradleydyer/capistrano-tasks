# Author: Anton McCook
# Symfony application tasks
# Symfony application tasks are run on 'web' and 'symfony' role
# global vars:
    # :release_path

namespace :symfony do
    namespace :app do
        task :remove_dev_mode do
            on roles(:web, :symfony) do
                info "Removing dev mode"
                execute :rm, "#{release_path}/web/app_dev.php"
                info "Dev mode removed"
            end
        end
    end
end
