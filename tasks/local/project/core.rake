# Author: Anton McCook - anton.mccook@bradleydyer.com
# local:project:core tasks
# local:project:core tasks are run locally

namespace :local do
    namespace :project do
        namespace :core do
            namespace :legacy do
                task :create_folder do
                    run_locally do
                        info "Create legacy folder"
                        execute "mkdir -p legacy"
                    end
                end

                task :permissions do
                    run_locally do
                        info "Change legacy folder permissions"
                        execute "sudo chmod -R 0777 legacy"
                    end
                end
            end
        end
    end
end
