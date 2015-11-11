# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'tyrionWeb'
set :repo_url, 'https://github.com/MapleLeaf7/tyrionWeb.git'
set :keep_releases, 5

set :scm_username, "maple_leaf_7@msn.com"
set :scm_password, "wyf198987"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/alidata/www/tyrionWeb'
set :user, "root"              #登录部署机器的用户名
set :password, "WYF198987"      #登录部署机器的密码， 如果不设部署时需要输入密码

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
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# role :web, "101.200.211.156"

# set :roles, "web"
#
# namespace :deploy do
#
#   task :destory, :roles => :web do
#     puts "------------------ after :restart -------------------"
#     exec 'echo "hello $HOSTNAME"'
#   end
#
#   # after :deploy, :clear_cache do
#   #   on roles(:web), in: :groups, limit: 3, wait: 10 do
#   #     # Here we can do anything such as:
#   #     # within release_path do
#   #     #   execute :rake, 'cache:clear'
#   #     # end
#   #     puts "------------------ after :restart -------------------"
#   #
#   #
#   #   end
#   # end
#
# end





