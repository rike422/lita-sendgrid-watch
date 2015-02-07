class StatusTopic
  REDIS_TITLESPACE = 'handlers:sendgrid_watch'.freeze
  REDIS_KEY = 'staustopic'.freeze
  class << self
    def all
      redis.hkeys(REDIS_KEY)
    end

    def create(url, title)
      redis.hset(REDIS_KEY, url, title)
    end

    def read(url)
      redis.hget(REDIS_KEY, url)
    end

    def destroy(url)
      redis.hdel(REDIS_KEY, url)
    end

    def exists?(url)
      redis.hexists(REDIS_KEY, url)
    end

    def redis
      @redis ||= Redis::Namespace.new(REDIS_TITLESPACE, redis: Lita.redis)
    end
  end
end
