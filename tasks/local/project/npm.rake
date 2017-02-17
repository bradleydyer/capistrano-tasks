# Author: Anton McCook - anton.mccook@bradleydyer.com
# local:project:npm tasks
# local:project:npm tasks are run locally
# global vars:

namespace :local do
    namespace :project do
        namespace :npm do
            task :install do
                run_locally do
                    info "Running npm install"
                    execute "npm install"
                end
            end
        end
    end
end
