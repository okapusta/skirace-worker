role :app, 'app@192.168.10.2'

after :deploy, "deploy:build"

after :deploy, "deploy:install"
