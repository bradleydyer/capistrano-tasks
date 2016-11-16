# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Apache tasks
# Apache tasks are run on 'web' and 'apache' roles

namespace :apache do
    namespace :service do
        # Reload graceful apache
        task :graceful do
            on roles(:web, :apache) do
                info "Reloading graceful apache"
                execute "sudo service apache2 graceful"
            end
        end
    end
end
