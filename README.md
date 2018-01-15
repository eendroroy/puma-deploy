# Puma Deploy
[![Contributors](https://img.shields.io/github/contributors/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/graphs/contributors)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/eendroroy/puma-deploy/master.svg)](https://github.com/eendroroy/puma-deploy)
[![license](https://img.shields.io/github/license/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/issues)
[![GitHub closed issues](https://img.shields.io/github/issues-closed/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub pull requests](https://img.shields.io/github/issues-pr/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/pulls)
[![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/eendroroy/puma-deploy.svg)](https://github.com/eendroroy/puma-deploy/pulls?q=is%3Apr+is%3Aclosed)
Rails-5 application deploy configuration using puma and nginx.

## Description

- Optional configuration of production and staging environments in same server.
- Embedded Nginx configuration.
- Embedded Puma init script and puma configuration.
- Log rotation.

### Prerequisites

Require following gems to be included in Gemfile.

- puma
- capistrano
- capistrano-bundler
- capistrano-rails
- capistrano-rbenv

```
gem 'puma', '~> 3.10'
group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
end
```

### Installing

- Copy following files in your application root maintaining the structure:

```
├── config
│   ├── deploy
│   │   ├── shared
│   │   │   ├── application.yml.template.erb
│   │   │   ├── database.yml.template.erb
│   │   │   ├── log_rotation.erb
│   │   │   ├── nginx.conf.erb
│   │   │   ├── puma_init.sh.erb
│   │   │   ├── puma.rb.erb
│   │   │   └── secrets.yml.template.erb
│   │   ├── production.rb
│   │   └── staging.rb
│   └── deploy.rb
├── lib
│   └── capistrano
│       ├── tasks
│       │   ├── check_revision.cap
│       │   ├── compile_assets_locally.cap
│       │   ├── logs.cap
│       │   ├── monit.cap
│       │   ├── nginx.cap
│       │   ├── reinit_db.cap
│       │   ├── remote.cap
│       │   ├── run_seed.cap
│       │   ├── run_tests.cap
│       │   └── setup_config.cap
│       ├── substitute_strings.rb
│       └── template.rb
└── Capfile
```

- Put rails project's git url under :repo_url in 'config/deploy.rb' file.

  Example:
  ```
  #config/deploy.rb
  set :repo_url, 'git@github.com:user/repo.git'
  
  ```
- Change application name under :application in 'config/deploy.rb' file.
  
  Example:
  ```
  #config/deploy.rb
  set :application, 'demo_application'
  ```
  
- Set server name in 'config/deploy/production.rb' and 'config/deploy/staging.rb' under :server_name
  
  Example:
  
  ```
  # config/deploy/production.rb
  set :server_name, 'example.prod'
  ```
  ```
  # config/deploy/staging.rb
  set :server_name, 'example.stage'
  ```
  
- Set Ip Address in 'config/deploy/production.rb' and 'config/deploy/staging.rb' under server
  
  Example:
  ```
  server '192.168.33.10', user: ...
  ```

## Usage

- To upload configurations
  
  ```
  $ bundle exec cap production deploy:setup_config
  ```

- To deploy  

  ```
  $ bundle exec cap production deploy
  ```

## Contributing

Bug reports and pull requests are welcome on GitHub at [puma-deploy repository](https://github.com/eendroroy/puma-deploy). 
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Authors

* **Indrajit Roy** - *Owner* - [eendroroy](https://github.com/eendroroy)

See also the list of [contributors](CONTRIBUTORS.md) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

