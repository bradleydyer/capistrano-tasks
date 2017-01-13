# Author: Anton McCook - asmccook@gmail.com
# Core CMS legacy infastructure task
# Core tasks are run on 'web' and 'core' role
# global vars:
    # :release_path
# vars:
    # :nfs_folder - nfs location path

namespace :core do
    namespace :legacy do

        task :symlink do
            on roles(:web, :core) do
                invoke 'core:legacy:symlink:create'
                info "Created legacy folder symlink"
            end
        end

        namespace :symlink do
            task :create do
                on roles(:web, :core) do
                    info "Create legacy folder symlink"
                    execute :ln, "-s", "#{fetch(:nfs_folder)}", "#{release_path}/legacy"
                end
            end
        end
    end
end
