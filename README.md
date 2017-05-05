# Puma Deploy

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
- capistrano-rails
- capistrano-rbenv

```
gem 'puma', '~> 3.0'
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
end
```

### Installing

- Copy following files in your application root maintaining the structure:

```
├── config
│   ├── deploy
│   │   ├── shared
│   │   │   ├── application.yml.template.erb
│   │   │   ├── database.yml.template.erb
│   │   │   ├── log_rotation.erb
│   │   │   ├── nginx.conf.erb
│   │   │   ├── puma.rb.erb
│   │   │   ├── puma_init.sh.erb
│   │   │   └── secrets.yml.template.erb
│   │   ├── production.rb
│   │   └── staging.rb
│   └── deploy.rb
├── lib
│   └── capistrano
│       ├── tasks
│       │   ├── check_revision.cap
│       │   ├── compile_assets_locally.cap
│       │   ├── logs.cap
│       │   ├── monit.cap
│       │   ├── nginx.cap
│       │   ├── restart.cap
│       │   ├── run_tests.cap
│       │   └── setup_config.cap
│       ├── substitute_strings.rb
│       └── template.rb
└── Capfile 
```
- Put rails project's git url under :repo_url

  Example:
  ```
  set :repo_url, 'git@github.com:user/repo.git'
  ```
  
- Set server name in production.rb and staging.rb under :server_name
  
  Example:
  
  ```
  # production.rb
  set :server_name, 'example.prod'
  ```
  ```
  # staging.rb
  set :server_name, 'example.stage'
  ```
  
- Set Ip Address in production.rb and staging.rb under server
  
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

* **Indrajit Roy** - *Fix nginx configs* - [eendroroy](https://github.com/eendroroy)

See also the list of [contributors](CONTRIBUTORS.md) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
