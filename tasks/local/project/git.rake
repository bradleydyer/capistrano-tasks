# Author: Kris Rybak - kris.rybak@bradleydyer.com
# local:project:git tasks
# local:project:git tasks are run locally
# global vars:
    # :application

namespace :local do
    namespace :project do
        namespace :git do
            namespace :hook do
                task :add do
                    run_locally do
                        info "Add git-hook"
                        execute "sudo echo 'git branch --merged develop | grep -v \'develop$\' | xargs git branch -d' > .git/hooks/post-merge"
                    end
                end

                task :permissions do
                    run_locally do
                        info "Change git-hook permissions"
                        execute "sudo chmod 0775 .git/hooks/post-merge"
                    end
                end

            end
        end
    end
end
