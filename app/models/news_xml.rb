class NewsXml < ActiveRecord::Base

  after_save :load_in_redis

  def load_in_redis
    $redis.set self.id, self.to_json
  end

end
