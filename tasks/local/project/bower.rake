# Author: Anton McCook - anton.mccook@bradleydyer.com
# local:project:bower tasks
# local:project:bower tasks are run locally
# global vars:

namespace :local do
    namespace :project do
        namespace :bower do
            task :install do
                run_locally do
                    info "Running bower install"
                    execute "bower install"
                end
            end

            task :update do
                run_locally do
                    info "Running bower update"
                    execute "bower update"
                end
            end
        end
    end
end
