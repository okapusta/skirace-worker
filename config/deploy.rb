# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'skirace-worker'
set :repo_url, 'git@192.168.1.139:skirace-worker.git'

set :deploy_to, '/home/app/skirace-worker'

set :scm, :git

set :stage, :rpi

namespace :deploy do

  desc 'Build gem'
  task :build do
    execute :gem, :build, 'skirace-worker-0.0.1.gem'  
  end

  desc 'Install gem'
  task :install do
    execute :gem, :install, 'skirace-worker-0.0.1.gem'
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end