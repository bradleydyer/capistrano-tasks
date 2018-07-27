# Author: Kris Rybak - kris.rybak@rybakdigital.com
# Npm Tasks
# Npm tasks are run on 'web' and 'npm' role
# global vars:
    # :release_path
# vars:
    # :npm_package_folder - npm package location, default same as release
    set :npm_package_folder, ""

    namespace :npm do
        namespace :installer do
            task :install do
                on roles(:web, :npm) do
                    info "Running npm install"
                    execute "cd #{release_path}#{fetch(:npm_package_folder)} && npm install"
                    info "npm install done"
                end
            end
        end
        namespace :rebuild do
            task :node-sass do
                on roles(:web, :npm) do
                    info "Running npm rebuild node-sass --force"
                    execute "cd #{release_path}#{fetch(:npm_package_folder)} && npm rebuild node-sass --force"
                    info "npm rebuild done"
                end
            end
        end
    end
    