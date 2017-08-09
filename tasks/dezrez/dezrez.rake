# Author: Anton McCook <anton.mccook@bradleydyer.com>
# Local dezrez tasks
# Dezrez tasks are run on roles web and dezrez

namespace :dezrez do
    namespace :cache do
        task :symlink do
            invoke 'dezrez:legacy:create_folder'
            invoke 'dezrez:legacy:symlink:data_folder'
        end
    end

    namespace :legacy do
        task :create_folder do
            on roles(:web, :dezrez) do |role|
                info "Creating legacy folder for Dezrez"
                execute "mkdir -p #{release_path}/vendor/Galliard/Dezrez/legacy"
            end
        end

        namespace :symlink do
            task :data_folder do
                on roles(:web, :dezrez) do |role|
                    info "Creating local legacy folder for Dezrez"
                    execute "ln -s #{fetch(:dezrez_cache_folder)}/data #{release_path}/vendor/Galliard/Dezrez/legacy/data"
                end
            end
        end
    end
end
