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

Requires following gems.

```
gem 'puma', '= 3.10.0'
group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rails-console'
  gem 'capistrano-rbenv'
end
```

### Installing

- **Copy following files in your application root maintaining the structure:**

```
.
├── Capfile
├── config
│  ├── deploy
│  │  ├── shared
│  │  │  ├── application.yml.template.erb
│  │  │  ├── database.yml.template.erb
│  │  │  ├── log_rotation.erb
│  │  │  ├── nginx.conf.erb
│  │  │  ├── puma.rb.erb
│  │  │  ├── puma_init.sh.erb
│  │  │  ├── secrets.yml.template.erb
│  │  ├── production.rb
│  │  └── staging.rb
│  └── deploy.rb
└── lib
   └── capistrano
      ├── substitute_strings.rb
      ├── tasks
      │  ├── check_revision.cap
      │  ├── compile_assets_locally.cap
      │  ├── db.cap
      │  ├── logs.cap
      │  ├── monit.cap
      │  ├── nginx.cap
      │  ├── puma.cap
      │  ├── run_tests.cap
      │  └── setup_config.cap
      └── template.rb
```

- **Put rails project's git url under :repo_url in 'config/deploy.rb' file.**

Example:
```ruby
#config/deploy.rb
set :repo_url, 'git@github.com:user/repo.git'
```

- **Change application name under :application in 'config/deploy.rb' file.**

Example:
```ruby
#config/deploy.rb
set :application, 'demo_application'
```

- **Define servers in 'config/deploy/production.rb' and 'config/deploy/staging.rb'**

Example:
```ruby
server '192.168.33.10', user: fetch(:deploy_user).to_s, roles: %w(app db), primary: true
server '192.168.33.11', user: fetch(:deploy_user).to_s, roles: %w(app), primary: true
server '192.168.33.12', user: fetch(:deploy_user).to_s, roles: %w(app), primary: true
```

- **Set server name in 'config/deploy/production.rb' and 'config/deploy/staging.rb'**
  
  Example:
  
```ruby
# config/deploy/production.rb
set :server_names, {
  '192.168.33.10': '192.168.33.10 node0.server',
  '192.168.33.11': '192.168.33.11 node1.server',
  '192.168.33.12': '192.168.33.12 node2.server',
}
```

- **Set certificate and key path in 'config/deploy/production.rb' and 'config/deploy/staging.rb'g**

```ruby
set :nginx_certificate_path, "#{shared_path}/certificates/#{fetch(:stage)}.crt"
set :nginx_key_path, "#{shared_path}/certificates/#{fetch(:stage)}.key"
```

_For different certificate and key name in different server_

```ruby
set :nginx_certificate_paths, {
  '192.168.33.10': "/etc/certificates/192_168_33_10.crt",
  '192.168.33.11': "/etc/certificates/192_168_33_11.crt",
  '192.168.33.12': "/etc/certificates/192_168_33_12.crt",
}
set :nginx_key_paths, {
  '192.168.33.10': "/etc/certificates/192_168_33_10.key",
  '192.168.33.11': "/etc/certificates/192_168_33_11.key",
  '192.168.33.12': "/etc/certificates/192_168_33_12.key",
}
```

_Note: configuration key name changes from `*_path` to `*_paths`_

## Usage

- **Upload configurations**
  
```bash
$ bundle exec cap production deploy:setup_config
```

- **Deploy**

```bash
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

