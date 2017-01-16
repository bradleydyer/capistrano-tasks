# Author: Anton McCook - asmccook@gmail.com
# Core CMS files task
# Core tasks are run on 'assets' role
# vars:
    # :nfs_folder - nfs location path

namespace :core do
    namespace :files do
        set :default_rsync_flags,     Array.[]('--archive', '--verbose', '--checksum', '--no-perms')
        set :excluded_download_paths, Array.[]('video/*', 'uploads/documents/*')
        set :excluded_upload_paths,   Array.[]('data/*', 'xml_files/*')

        # Creates a string of excludes
        # params:
            # paths - An array of paths to transform into a string of exludes
        # return: string
        def create_excludes_string(paths)
            transformed_paths = paths.map { |path| "--exclude=\"" + path + "\"" };
            exclude_string = transformed_paths.join(' ')

            return exclude_string
        end

        # Creates a string of rsync flags
        # params:
            # additional_flags - An array of additional flags to transform with the defaults
        # return: string
        def create_rsync_flags_string(additional_flags=nil)
            flags = fetch(:default_rsync_flags).dup

            if additional_flags.kind_of?(Array)
                flags.concat(additional_flags)
            end

            return flags.join(' ')
        end

        task :download do
            invoke 'local:project:core:legacy:create_folder'
            invoke 'core:files:download:start'
            invoke 'local:project:core:legacy:permissions'
        end

        task :upload do
            invoke 'core:files:upload:dry_run'
            invoke 'core:files:upload:confirmation'
        end

        namespace :download do
            task :start do
                on roles(:assets) do |role|
                    run_locally do
                        set :excludes, create_excludes_string(fetch(:excluded_download_paths))
                        set :flags,    create_rsync_flags_string()
                        execute "rsync #{fetch(:flags)} #{fetch(:excludes)} #{role.user}@#{role.hostname}:#{fetch(:nfs_folder)}/ legacy/"
                    end
                end
            end
        end

        namespace :upload do
            task :start do
                on roles(:assets) do |role|
                    run_locally do
                        set :excludes, create_excludes_string(fetch(:excluded_upload_paths))
                        set :flags,    create_rsync_flags_string()
                        execute "rsync #{fetch(:flags)} #{fetch(:excludes)} legacy/ #{role.user}@#{role.hostname}:#{fetch(:nfs_folder)}/"
                    end
                end
            end

            task :dry_run do
                on roles(:assets) do |role|
                    run_locally do
                        set :excludes, create_excludes_string(fetch(:excluded_upload_paths))
                        set :flags,    create_rsync_flags_string(Array.[]('--dry-run'))
                        execute "rsync #{fetch(:flags)} #{fetch(:excludes)} legacy/ #{role.user}@#{role.hostname}:#{fetch(:nfs_folder)}/"
                    end
                end
            end

            task :confirmation do
                run_locally do
                    set :is_confirmed, ask("'Y' to confirm the files above should be uploaded.")
                    answer = fetch(:is_confirmed)

                    if answer == "Y" || answer == "y"
                        invoke 'core:files:upload:start'
                    else
                        info "Files upload aborted!"
                    end
                end
            end
        end
    end
end
