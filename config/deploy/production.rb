set :stage, :production
set :branch, 'master'

set :server_name, 'bi-tool.prod'

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"

server '__ip__', user: fetch(:deploy_user).to_s, roles: %w(web app db), primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:full_app_name)}"

set :rails_env, :production

set :puma_user, fetch(:deploy_user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/states/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.#{fetch(:full_app_name)}.sock"
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.#{fetch(:full_app_name)}.sock"
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, :production
set :puma_threads, [0, 2]
set :puma_workers, 4
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, true
set :puma_plugins, [:tmp_restart]
set :nginx_use_ssl, false
set :nginx_sites_available_path, '/etc/nginx/available.d'
set :nginx_sites_enabled_path, '/etc/nginx/conf.d'
