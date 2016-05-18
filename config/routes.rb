Rails.application.routes.draw do

  put 'download_news_xmls' => 'pages#get_news', as: 'get_news_xmls'

  root 'pages#index'

end
