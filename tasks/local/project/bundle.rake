# Author: Kris Rybak - kris.rybak@bradleydyer.com
# local:project:bundle tasks
# local:project:bundle tasks are run locally
# global vars:
    # :application

namespace :local do
    namespace :project do
        namespace :bundle do
            task :install do
                run_locally do
                    info "Install Gemfile dependancies"
                    execute "bundle install --path vendor/gems"
                end
            end
        end
    end
end
