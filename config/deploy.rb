# config valid only for current version of Capistrano
# require 'capistrano/rvm'
# require 'capistrano/bundler'
lock '3.4.0'
# require 'capistrano/rvm'
# require 'capistrano/bundler'

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :application, 'tyrionWeb'
set :repo_url, 'https://github.com/MapleLeaf7/tyrionWeb.git'
set :keep_releases, 5
set :deploy_via, :remote_cache

set :user, "maple_leaf_7@msn.com"
set :password, "wyf198987"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :keep_releases, 5          #只保留5个备份
set :deploy_to, "/alidata/www/tyrionWeb"
# set :deploy_to, "~/"
set :user, "root"              #登录部署机器的用户名
set :password, "WYF198987"      #登录部署机器的密码， 如果不设部署时需要输入密码
set :use_sudo, true

set :unicorn_path, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/current/tmp/pids/unicorn.pid"

set :default_env, { rvm_bin_path: '/usr/local/rvm/bin' }

# set :rvm_map_bins, %w{gem rake ruby bundle}
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
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :runner, "root"
role :web, "101.200.211.156"
set :roles, "web"
`ssh-add`
namespace :bundler do
  desc "Run bundler, installing gems"
  task :install_app do
    on roles(:web) do
      execute("cd /alidata/www/tyrionWeb/current;bundle install")
    end
  end
end

namespace :deploy do

  %w(start stop restart).each do |action|
    desc "unicorn:#{action}"
    task action.to_sym do
      invoke "unicorn:#{action}"
      #find_and_execute_task("unicorn:#{action}")
    end
  end

  after 'deploy', 'restart'
end

namespace :unicorn do

  desc "Start unicorn"
  task :start do
    on roles(:app) do
      execute "cd /alidata/www/tyrionWeb/current ; unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -E development -D"

      # execute "export PATH=$PATH:/usr/local/rvm/gems/ruby-2.2.1@global/bin;bundle install"
      # execute "echo $PATH"
      # execute "cd /alidata/www/tyrionWeb/current ; bundle install"
      # execute "cd /alidata/www/tyrionWeb/current ; pwd"
      # execute "vim /etc/profile"
      # sleep(5)
      # execute "pwd"
      # execute "unicorn_rails -c /alidata/www/tyrionWeb/current/config/unicorn.rb -D -E development"
    end
  end


  desc "Stop unicorn"
  task :stop do
    on roles(:web) do
      puts "------------------ Stop unicorn -------------------"
      execute "kill -9 `cat /alidata/www/tmp/unicorn.pid`"
    end
  end


  desc "Restart unicorn"
  task :restart do
    on roles(:app) do
      puts "------------------ Restart unicorn -------------------"
      execute "kill -9 `cat /alidata/www/tmp/unicorn.pid`"
      sleep(5)
      execute "cd /alidata/www/tyrionWeb/current ; unicorn_rails -c #{deploy_to}/current/config/unicorn.rb -E development -D"
    end
  end
end





