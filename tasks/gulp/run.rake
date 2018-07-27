# Author: Kris Rybak - kris.rybak@rybakdigital.com
# Gulp Tasks
# Gulp tasks are run on 'web' and 'gulp' role
# global vars:
    # :release_path
# vars:
    # :gulp_package_folder - gulp package location, default same as release
    set :gulp_package_folder, ""

    namespace :gulp do
        namespace :run do
            task :production do
                on roles(:web, :gulp) do
                    info "Running gulp with --production flag"
                    execute "cd #{release_path}#{fetch(:npm_package_folder)} && gulp --production"
                    info "gulp task done"
                end
            end

            task :build do
                on roles(:web, :gulp) do
                    info "Running gulp build"
                    execute "cd #{release_path}#{fetch(:npm_package_folder)} && gulp build"
                    info "gulp build task done"
                end
            end

            task :default do
                on roles(:web, :gulp) do
                    info "Running gulp default task"
                    execute "cd #{release_path}#{fetch(:npm_package_folder)} && gulp"
                    info "gulp task done"
                end
            end
        end
    end
    