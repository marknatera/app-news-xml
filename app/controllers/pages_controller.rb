class PagesController < ApplicationController

  def index
    # @articles = []
    # @redis_xmls = $redis.keys('*')
    # @redis_xmls.each do |key|
    #   @articles << JSON.parse($redis.get(key))
    # end
    # @articles
  end

  def get_news
    call_rake :download_news_xmls
    flash[:notice] = "Getting NewsXMLs"
    redirect_to root_path
  end
end
