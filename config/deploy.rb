# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'skirace-worker'
set :repo_url, 'git@192.168.1.138:skirace-worker.git'

set :deploy_to, '/home/app/skirace-worker'

namespace :deploy do

  desc 'Build gem'
  task :build do
    on roles(:app) do
      execute "cd #{current_path}"
      execute :gem, :build, 'skirace-worker.gemspec'
    end  
  end

  desc 'Install gem'
  task :install do
    on roles(:app) do
      execute "cd #{current_path}"
      execute :gem, :install, 'skirace-worker-0.0.1.gem'
    end
  end

  desc 'Start God'
  task :start_god do
    on roles(:app) do
      execute "cd #{current_path} && bundle exec god -c config/god.rb -D"
    end
  end
end
