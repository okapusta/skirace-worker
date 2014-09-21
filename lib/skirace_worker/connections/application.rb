class Connections::Application
  takes :http_client, :options

  def end_time(time)
    http_client.post options.api_url, end_time: time
  end

end
