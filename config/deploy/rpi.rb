role :app, 'app@192.168.1.2'

after :deploy, "deploy:build"
#after :deploy, "deploy:install"#, "deploy:start_god"