# Author: Anton McCook - anton.mccook@bradleydyer.com
# local:project:symfony tasks
# local:project:symfony tasks are run locally

namespace :local do
    namespace :project do
        namespace :symfony do
            namespace :assets do
                task :install do
                    run_locally do
                        info "Running bin/console assets:install"
                        execute "php bin/console assets:install --env=dev"
                        execute "php bin/console assets:install --env=prod"
                        info "Assets installed"
                    end
                end

                task :dump do
                    run_locally do
                        info "Running bin/console assetic:dump"
                        execute "php bin/console assetic:dump --env=dev"
                        execute "php bin/console assetic:dump --env=prod"
                        info "Assets dumped"
                    end
                end
            end

            namespace :cache do
                task :clear do
                    run_locally do
                        info "Running bin/console cache:clear"
                        execute "php bin/console cache:clear --env=dev"
                        execute "php bin/console cache:clear --env=prod --no-warmup --no-debug"
                        info "Cache cleared"
                    end
                end

                task :warmup do
                    run_locally do
                        info "Running bin/console cache:warmup"
                        execute "php bin/console cache:warmup --env=dev"
                        execute "php bin/console cache:warmup --env=prod"
                        info "Cache warmup complete"
                    end
                end

                task :permissions do
                    run_locally do
                        info "Updating cache permissions"
                        execute "sudo chmod -R 0777 var"
                        info "Cache permissions updated"
                        Rake::Task['local:project:symfony:cache:permissions'].reenable
                    end
                end
            end
        end
    end
end
