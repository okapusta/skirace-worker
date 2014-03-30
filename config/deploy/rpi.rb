role :app, 'app@192.168.1.149'

after :deploy, "deploy:build", "deploy:install"#, "deploy:start_god"