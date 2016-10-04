# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Apache tasks
# Apache tasks are run on 'web' and 'apache' roles

namespace :apache_apache2ctl do
    # Reload graceful apache
    task :graceful do
        on roles(:web, :apache) do
            info "Reloading graceful apache"
            execute "sudo apache2ctl graceful"
        end
    end
end
