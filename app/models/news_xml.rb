class NewsXml < ActiveRecord::Base

  after_save :load_in_redis

  def load_in_redis
    $redis.set 'data', self.to_json
    # data = JSON.parse($redis.get("data"))
  end

end
