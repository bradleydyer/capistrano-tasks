# Author: Kris Rybak - kris@krisrybak.com
# Assets tasks
# Assets tasks are run on 'web' and 'assets' role
# vars:
    # :nfs_folder - nfs location path

namespace :assets do
    namespace :permissions do
        task :fix do
            on roles(:web, :assets) do
                if test("[ -d #{fetch(:nfs_folder)} ]")
                    invoke 'assets:permissions:nfs:fix'
                else
                    invoke 'assets:permissions:nfs:create'
                    invoke 'assets:permissions:nfs:fix'
                end
            end
        end

        namespace :nfs do
            # Create nfs folder
            task :create do
                on roles(:web, :assets) do
                    info "Create nfs files"
                    execute "mkdir -p #{fetch(:nfs_folder)}"
                end
            end

            # Fix nfs folder permissions
            task :fix do
                on roles(:web, :assets) do
                    info "fixing remote assets permissions"
                    if remote_file_exists?("#{fetch(:nfs_folder)}")
                        execute "sudo find #{fetch(:nfs_folder)}  ! \\( -user www-data -and -group deploy \\) -exec chown www-data:deploy {} \\;"
                        execute "sudo find #{fetch(:nfs_folder)}  -type d -exec chmod g+rwxs {} \\;"
                    end
                end
            end
        end
    end
end
