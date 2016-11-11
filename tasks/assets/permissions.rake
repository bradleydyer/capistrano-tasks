# Author: Kris Rybak - kris@krisrybak.com
# Assets tasks
# Assets tasks are run on 'web' and 'assets' role
# vars:
    # :nfs_folder - nfs location path

namespace :assets do
    namespace :permissions do
        task :fix do
            on roles(:web, :assets) do
                info "fixing remote assets permissions"
                execute "sudo find #{fetch(:nfs_folder)}  ! \\( -user www-data -and -group deploy \\) -exec chown www-data:deploy {} \\;"
                execute "sudo find #{fetch(:nfs_folder)}  -type d -exec chmod g+rwxs {} \\;"
            end
        end
    end
end
