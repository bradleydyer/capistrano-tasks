# Author: Kris Rybak - kris@krisrybak.com
# Wordpress Assets tasks
# Wordpress tasks are run on 'web' and 'wordpress' role
# global vars:
    # :release_path
    # :stage
# vars:
    # :nfs_folder - nfs location path
set :wordpress_assets_files_folder, "web/wp-content/uploads"

namespace :wordpress do
    namespace :assets do

        task :symlink do
            on roles(:web, :wordpress) do
                invoke 'wordpress:assets:symlink:files'
                info "Created symlinks to uploads"
            end
        end

        namespace :symlink do
            task :files do
                on roles(:web, :wordpress) do
                    info "Create shared files"
                    execute "mkdir -p #{fetch(:nfs_folder)}/uploads"
                    execute :rm, "-rf", "#{release_path}/#{fetch(:assets_files_folder)}"
                    execute :ln, "-s", "#{fetch(:nfs_folder)}/uploads", "#{release_path}/#{fetch(:assets_files_folder)}"
                end
            end
        end
    end
end
