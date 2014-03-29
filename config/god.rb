God.watch do |god|
  god.name "skirace-worker"
  god.start "rvmsudo bundle exec skirace-worker"
  god.keepalive
end