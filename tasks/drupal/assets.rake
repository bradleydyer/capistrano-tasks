# Author: Kris Rybak - kris@krisrybak.com
# Drupal Assets tasks
# Drupal tasks are run on 'web' and 'drupal' role
# global vars:
    # :release_path
    # :stage
# vars:
    # :nfs_folder - nfs location path
set :assets_files_folder, "web/sites/default/files"
set :assets_private_folder, "web/sites/default/private"

namespace :drupal do
    namespace :assets do

        task :symlink do
            on roles(:web, :drupal) do
                invoke 'drupal:assets:symlink:files'
                invoke 'drupal:assets:symlink:private'
            end
        end


        namespace :symlink do
            task :files do
                on roles(:web, :drupal) do
                    info "Create shared files"
                    execute "mkdir -p #{fetch(:nfs_folder)}/files"
                    execute "mkdir -p #{shared_path}/#{fetch(:assets_files_folder)}"
                    execute :rm, "-rf", "#{shared_path}/#{fetch(:assets_files_folder)}"
                    execute :ln, "-s", "#{fetch(:nfs_folder)}/files", "#{shared_path}/#{fetch(:assets_files_folder)}"
                end
            end

            task :private do
                on roles(:web, :drupal) do
                    info "Creating empty settings.php file"
                    execute :touch, "#{release_path}/web/sites/default/settings.php"
                    info "settings.php file has been created"
                end
            end
        end
    end
end
