# Author: Kris Rybak - kris.rybak@bradleydyer.com
# Git Tag tasks
# Git Tag tasks are locally
# global vars:
    # :branch
# vars:
    # :default_tag  - Latest git tag
    # :tag          - Tag used for deployment
    # :tags         - List of available tags

namespace :git do
    set :default_tag, ""
    set :tag, ""
    set :tags, []

    namespace :tag do
        task :check do
            run_locally do
                until fetch(:tags).include?(fetch(:tag)) do
                    invoke 'git:tag:fetch'
                    invoke 'git:tag:ask'

                    if fetch(:tags).include?(fetch(:tag)) then
                        puts("Will deploy tag #{fetch(:tag)}")
                        set :branch, "#{fetch(:tag)}"
                    else
                        puts("Could not find #{fetch(:tag)}. Please check your tag and try again")
                    end
                end
            end
        end

        task :fetch do
            run_locally do
                info "Fetching remote git tags"
                execute "git fetch --tags"
                Rake::Task['git:tag:fetch'].reenable
            end
        end

        task :ask do
            run_locally do
                set :default_tag, `git tag`.split("\n").last
                set :tags, `git tag`.split("\n")
                ask(:answer, "Tag to deploy? [#{fetch(:default_tag)}]")

                if fetch(:answer) == "Tag to deploy? [#{fetch(:default_tag)}]" then
                    set :tag, fetch(:default_tag)
                else
                    set :tag, fetch(:answer)
                end

                Rake::Task['git:tag:ask'].reenable
            end
        end
    end
end
