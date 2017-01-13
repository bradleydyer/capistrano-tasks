# Author: Anton McCook - asmccook@gmail.com
# Core CMS zend task
# Core tasks are run on 'core' role
# global vars:
    # :release_path

namespace :core do
    namespace :zend do

        task :symlink do
            on roles(:web, :core) do
                invoke 'core:zend:symlink:create'
                info "Created Zend folder symlink"
            end
        end

        namespace :symlink do
            task :create do
                on roles(:web, :core) do
                    info "Remove existing Zend folder"
                    execute :rm, "#{release_path}/library/Zend"
                    info "Create the Library/Zend folder symlink"
                    execute :ln, "-s", "#{release_path}/vendor/zwilias/zend-framework-1/src/Zend/", "#{release_path}/library/Zend"
                end
            end
        end
    end
end
