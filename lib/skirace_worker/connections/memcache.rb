class Connections::Memcache
  takes :options

  attr_accessor :memcache_connection

  def get(key)
    memcache_connection.get(key)
  end

  private
    
    def client
      @client ||= ::Dalli::Client.new(options.memcache_server, options.memcache_client)
    end
    alias_method :memcache_connection, :client
end
