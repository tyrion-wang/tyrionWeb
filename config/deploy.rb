# config valid only for current version of Capistrano
lock '3.4.0'

set :stages, %w(staging production)
set :default_stage, 'staging'

set :application, 'tyrionWeb'
set :repo_url, 'https://github.com/MapleLeaf7/tyrionWeb.git'
set :keep_releases, 5
set :deploy_via, :remote_cache

# set :user, 'maple_leaf_7@msn.com'
# set :password, 'wyf198987'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :keep_releases, 5          #只保留5个备份
set :deploy_to, '/alidata/www/tyrionWeb'
# set :deploy_to, "~/"
# set :use_sudo, true


# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

role :web, '101.200.211.156'
set :roles, 'web'
`ssh-add` #秘钥登录
namespace :deploy do

  desc 'create db'
  task :create_db do
    on roles(:web) do
      execute "cd #{deploy_to}/current &&  rake db:create RAILS_ENV=development"
    end
  end

  desc 'migrate db'
  task :migrate_db do
    on roles(:web) do
      execute "cd #{deploy_to}/current &&  rake db:migrate RAILS_ENV=development"
    end
  end

  %w(start stop restart).each do |action|
    desc "unicorn:#{action}"
    task action.to_sym do
      invoke "unicorn:#{action}"
      #find_and_execute_task("unicorn:#{action}")
    end
  end

  after 'deploy', 'restart'
end

namespace :bundler do
  desc 'Run bundler, installing gems'
  task :install do
    on roles(:web) do
      execute("cd #{deploy_to}/current;bundle install")
    end
  end
end

namespace :unicorn do

  desc 'Start unicorn'
  task :start do
    on roles(:app) do
      execute "cd /alidata/www/tyrionWeb/current ; unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -E development -D"
    end
  end


  desc 'Stop unicorn'
  task :stop do
    on roles(:web) do
      execute 'kill -9 `cat /alidata/www/tmp/unicorn.pid`'
    end
  end


  desc 'Restart unicorn'
  task :restart do
    on roles(:app) do
      execute 'kill -9 `cat /alidata/www/tmp/unicorn.pid`'
      sleep(1)
      execute "cd /alidata/www/tyrionWeb/current ; unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -E development -D"
    end
  end
end





