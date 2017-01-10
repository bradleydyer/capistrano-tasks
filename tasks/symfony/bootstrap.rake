# Author: Anton McCook
# Symfony application tasks
# Symfony application tasks are run on 'web' and 'symfony' role
# global vars:
    # :release_path

namespace :symfony do
    namespace :bootstrap do
        task :build do
            on roles(:web, :symfony) do
                info "Building bootstrap"
                execute "cd #{release_path} && php vendor/sensio/distribution-bundle/Sensio/Bundle/DistributionBundle/Resources/bin/build_bootstrap.php"
                info "Bootstrap build complete"
            end
        end
    end
end
