# Author: Anton McCook <anton.mccook@bradleydyer.com>
# local:project:drupal tasks
# local:project:drupal tasks are run locally
# global vars:
    # :application

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
        end
    end
end
