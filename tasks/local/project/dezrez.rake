# Author: Anton McCook <anton.mccook@bradleydyer.com>
# Local dezrez tasks
# Dezrez tasks are run locally, cache is downloaded from environment with role dezrez_cache_download

namespace :local do
    namespace :project do
        namespace :dezrez do
            namespace :legacy do
                task :create_folder do
                    run_locally do
                        info "Creating local legacy folder for Dezrez"
                        execute "mkdir -p vendor/Galliard/Dezrez/legacy"
                    end
                end

                namespace :symlink do
                    task :data_folder do
                        run_locally do
                            info "Creating local legacy folder for Dezrez"
                            execute "cd vendor/Galliard/Dezrez; rm -f data; ln -s legacy/data data"
                        end
                    end
                end
            end

            namespace :cache do
                task :download do
                    invoke 'local:project:dezrez:legacy:create_folder'
                    invoke 'local:project:dezrez:legacy:symlink:data_folder'
                    invoke 'local:project:dezrez:cache:download:start'
                    invoke 'local:project:dezrez:cache:permissions'
                end

                task :permissions do
                    run_locally do
                        info "Updating permissions for Dezrez cache"
                        execute "sudo chmod -R 777 vendor/Galliard/Dezrez/legacy/"
                    end
                end

                namespace :download do
                    task :start do
                        on roles(:dezrez_cache_download) do |role|
                            run_locally do
                                info "Downloading Dezrez cache"
                                execute "rsync --archive --verbose --checksum --no-perms --exclude=\"log---*\" #{role.user}@#{role.hostname}:#{fetch(:dezrez_cache_folder)}/ vendor/Galliard/Dezrez/legacy/"
                            end
                        end
                    end
                end
            end
        end
    end
end
