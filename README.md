# capistrano-tasks

List of capistrano tasks used on BradleyDyer infrastructure.

## Usage and Installation
 - Add to your composer.json dependencies:
```
...
    "require-dev": {
        ...,
        "bradleydyer/capistrano-tasks": "^1.5",
    }
```
 - run `composer update`
 - load tasks in your Capfile
```ruby
Dir.glob('vendor/bradleydyer/capistrano-tasks/tasks/*/*.rake').each { |r| import r }
Dir.glob('vendor/bradleydyer/capistrano-tasks/tasks/*/*/*.rake').each { |r| import r }
```

### Tag based deployment
If you wish to deploy specific tag you can enable that by adding `before :deploy, "git:tag:check"` for a given stage (typically `production.rb`). This can also be enabled globally. Once enabled, you will be asked during deployment to specify tag you wish to deploy. Specifying invalid tag will re-fetch tags trigger the prompt once again.

## Badges
* [![cap-deploy.png](https://raw.githubusercontent.com/bradleydyer/asset-kit/master/labels/capistrano-tasks/cap-deploy.png)](cap-deploy) - For capistrano-task enabled projects
* [![cap-install.png](https://raw.githubusercontent.com/bradleydyer/asset-kit/master/labels/capistrano-tasks/cap-install.png)](cap-install) - For projects that are configured to be installed loacly
* [![cap-upload.png](https://raw.githubusercontent.com/bradleydyer/asset-kit/master/labels/capistrano-tasks/cap-upload.png)](cap-upload) - For projects that allow to push files up
* [![cap-download.png](https://raw.githubusercontent.com/bradleydyer/asset-kit/master/labels/capistrano-tasks/cap-download.png)](cap-download) - For projects that allow to pull files down

## Setup for Developers

[CONTRIBUTING.md](https://github.com/bradleydyer/capistrano-tasks/blob/master/CONTRIBUTING.md)

- Write code
- Be awesome
