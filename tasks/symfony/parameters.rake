# Author: Anton McCook
# Symfony parameter tasks
# Symfony parameter tasks are run on 'web' and 'symfony' role
# global vars:
    # :release_path

namespace :symfony do
    namespace :parameters do
        task :install do
            on roles(:web, :symfony) do
                info "Installing parameters file"
                execute "cp #{fetch(:symfony_parameters_source_folder)}/#{fetch(:application)}/parameters.yml #{release_path}/app/config/parameters.yml"
                info "Parameters file installed"
            end
        end
    end
end
