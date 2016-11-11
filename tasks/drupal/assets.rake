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
                info "Created symlinks to files and private"
            end
        end

        task :permissions do
            on roles(:web, :drupal) do
                info "fixing remote assets permissions"
                execute "sudo find #{fetch(:nfs_folder)}  ! \\( -user www-data -and -group deploy \\) -exec chown www-data:deploy {} \\;"
                execute "sudo find #{fetch(:nfs_folder)}  -type d -exec chmod g+rwxs {} \\;"
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
                    info "Create shared private"
                    execute "mkdir -p #{fetch(:nfs_folder)}/private"
                    execute "mkdir -p #{shared_path}/#{fetch(:assets_private_folder)}"
                    execute :rm, "-rf", "#{shared_path}/#{fetch(:assets_private_folder)}"
                    execute :ln, "-s", "#{fetch(:nfs_folder)}/private", "#{shared_path}/#{fetch(:assets_private_folder)}"
                end
            end
        end
    end
end
