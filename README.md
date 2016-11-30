# capistrano-tasks

List of capistrano tasks used on BradleyDyer infrastructure.

## Usage and Installation
 - Add to your composer.json dependencies:
```
...
    "require": {
        ...,
        "bradleydyer/capistrano-tasks": "^0.0",
    },
    "repositories": [
        ...,
        {
            "type": "vcs",
            "url": "git@git-master.bd-ns.net:bradleydyer/capistrano-tasks.git"
        }
    ]
```
 - run `composer update`
 - load tasks in your Capfile
```ruby
Dir.glob('vendor/bradleydyer/capistrano-tasks/tasks/*/*.rake').each { |r| import r }
```

### Tag based deployment
If you wish to deploy specific tag you can enable that by adding `before :deploy, "git:tag:check"` for a given stage (typically `production.rb`). This can also be enabled globally. Once enabled, you will be asked during deployment to specify tag you wish to deploy. Specifying invalid tag will re-fetch tags trigger the prompt once again.

## Setup for Developers

 - Read the Installation guidelines

[INSTALLATION.md](https://git-master.bd-ns.net/bradleydyer/capistrano-tasks/blob/master/INSTALLATION.md)

 - Read the Contributing guidelines

[CONTRIBUTING.md](https://git-master.bd-ns.net/bradleydyer/capistrano-tasks/blob/master/CONTRIBUTING.md)

- Write code
- Be awesome
