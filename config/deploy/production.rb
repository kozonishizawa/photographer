# frozen_string_literal: true

lock '3.11.2'

require 'yaml'
require 'capistrano/sidekiq'

set :application, 'photographer'

# environment
set :rails_env, 'production'

# set :scm, :git
set :keep_releases, 3

# Default value for linked_dirs is []
append :linked_dirs,
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'tmp/storage',
  'node_modules',
  'vendor/bundle',
  'public/sitemaps',
  'public/packs'

# 指定ファイルに変化が生じた場合にprecompileを行う
set :assets_dependencies, %w[app/assets app/javascript package.json yarn.lock config/webpack]

# ruby
set :rbenv_ruby, '2.6.3'
set :default_env, { path: '~/.rbenv/shims:~/.rbenv/bin:$PATH' }

# load system config
configs = YAML.load_file('config/system_config.yml')[fetch(:rails_env)]

set :repo_url, 'git@github.com:kozonishizwa/photographer.git'
set :branch, 'master'
set :deploy_to, '/home/media'
set :log_level, :debug
set :default_shell, '/bin/bash -l'

server configs['deploy_server'], user: 'media', roles: %w[app assets batch db]

set :assets_roles, [:assets]

# puma
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_threads, [4, 16]
set :puma_workers, 2
set :puma_worker_timeout, nil

# sidekiq
set :sidekiq_role, :batch

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  # migration前にdatabaseを作成する
  before :migrate, :db_create do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          info 'creating database...'
          execute :rails, 'db:create'
        end
      end
    end
  end
end