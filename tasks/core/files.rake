# Author: Anton McCook - asmccook@gmail.com
# Core CMS files task
# Core tasks are run on 'assets' role
# vars:
    # :nfs_folder - nfs location path

namespace :core do
    namespace :files do

        task :download do
            invoke 'local:project:core:legacy:create_folder'
            invoke 'core:files:download:start'
            invoke 'local:project:core:legacy:permissions'
        end

        namespace :download do
            task :start do
                    on roles(:assets) do |role|
                    run_locally do
                        # Sync the legacy folders
                        execute "rsync -avc --exclude=\"video/*\" --exclude=\"uploads/documents/*.pdf\" #{role.user}@#{role.hostname}:#{fetch(:nfs_folder)}/ legacy/"
                    end
                end
            end
        end
    end
end
