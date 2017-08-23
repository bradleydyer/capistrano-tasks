# Author: Anton McCook <anton.mccook@bradleydyer.com>
# local:project:drupal tasks
# local:project:drupal tasks are run locally

namespace :local do
    namespace :project do
        namespace :drupal do
            namespace :settings do
                # Ask the user for the settings file location
                # return: string
                def ask_settings_file_location()
                    location = "config/environment/local/settings/settings.php"
                    set :location, ask("the file location for settings.php\nDefault: #{location}");
                    input = fetch(:location);

                    if(input != nil)
                        location = input
                    end

                    return location;
                end

                task :install do
                    run_locally do
                        info "Installing settings file"

                        file = ask_settings_file_location()

                        if File.file?(file) == false
                            abort "The settings file #{file} does not exist"
                        end

                        execute "cp #{file} web/sites/default/settings.php"
                    end
                end
            end

            namespace :files do
                set :default_rsync_flags,     Array.[]('--archive', '--verbose', '--checksum', '--no-perms')

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
                    invoke 'local:project:drupal:files:download:start'
                end

                namespace :download do
                    task :start do
                        on roles(:assets) do |role|
                            run_locally do
                                set :flags,    create_rsync_flags_string()
                                execute "rsync #{fetch(:flags)} #{role.user}@#{role.hostname}:#{fetch(:nfs_folder)}/ assets/"
                            end
                        end
                    end
                end

                task :symlink do
                    run_locally do
                        set :cwd, capture('pwd')
                        execute "rm -f web/sites/default/files"
                        execute "rm -f web/sites/default/private"
                        execute "ln -s #{fetch(:cwd)}/assets/files web/sites/default/files"
                        execute "ln -s #{fetch(:cwd)}/assets/private web/sites/default/private"
                    end
                end

                task :permissions do
                    run_locally do
                        execute "sudo chmod -R 777 assets/"
                    end
                end
            end
        end
    end
end
