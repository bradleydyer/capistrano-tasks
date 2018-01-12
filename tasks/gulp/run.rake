# Author: Kris Rybak - kris.rybak@rybakdigital.com
# Gulp Tasks
# Gulp tasks are run on 'web' and 'gulp' role
# global vars:
    # :release_path

    namespace :gulp do
        namespace :run do
            task :production do
                on roles(:web, :gulp) do
                    info "Running gulp with --production flag"
                    execute "cd #{release_path} && gulp --production"
                    info "gulp task done"
                end
            end

            task :default do
                on roles(:web, :gulp) do
                    info "Running gulp default task"
                    execute "cd #{release_path} && gulp"
                    info "gulp task done"
                end
            end
        end
    end
    