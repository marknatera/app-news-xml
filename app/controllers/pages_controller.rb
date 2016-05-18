class PagesController < ApplicationController

  def index
    @news = NewsXml.all
  end

  def get_news
    call_rake :download_news_xmls
    flash[:notice] = "Getting NewsXMLs"
    redirect_to root_path
  end
  # data = JSON.parse($redis.get("data"))
end
