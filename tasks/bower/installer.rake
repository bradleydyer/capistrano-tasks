# Author: Anton McCook - asmccook@gmail.com
# Bower Tasks
# Bower tasks are run on 'web' and 'bower' role
# global vars:
    # :release_path

namespace :bower do
    namespace :installer do
        task :install do
            on roles(:web, :bower) do
                info "Running bower install"
                execute "cd #{release_path} && bower install"
                info "Bower install done"
            end
        end

        task :update do
            on roles(:web, :bower) do
                info "Running bower update"
                execute " cd #{release_path} && bower update"
                info "Bower update done"
            end
        end
    end
end
