# Author: Kris Rybak - kris.rybak@bradleydyer.com
# local:project:vhost tasks
# local:project:vhost tasks are run locally
# global vars:
    # :application

namespace :local do
    namespace :project do
        namespace :vhost do
            task :install do
                run_locally do
                    if test("[ -f config/environment/local/vhosts/vhost.conf ]")
                        info "Installing vhost for #{fetch(:application)}.."
                        execute "sudo cp config/environment/local/vhosts/vhost.conf /etc/apache2/sites-available/#{fetch(:application)}.conf"
                    end
                end
            end
        end
    end
end
