God.watch do |god|
  god.name "skirace-worker"
  god.start "rvmsudo bundle exec skirace-worker &"
  god.pid_file = File.join('.', 'tmp', 'skirace-worker.pid')
  god.behavior :clean_pid_file
  god.keepalive
end