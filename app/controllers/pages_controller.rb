class PagesController < ApplicationController

  require 'net/http'
  require 'uri'
  require 'zip/zip'

  def download_resource(resource, filename)
    url = "http://bitly.com/nuvi-plz"
    uri = URI.parse(url)
    req = Net::HTTP::Get.new(uri.path)
    filename = './test.zip'

    # download the zip
    File.open(filename,"wb") do |file|
      Net::HTTP::Proxy(proxy_host, proxy_port, proxy_user, proxy_pass).start(uri.host, uri.port) do |http|
        http.get(uri.path) do |str|
          file.write str
        end
      end
    end

    # and show it's contents
    Zip::ZipFile.open(filename) do |zip|
      # zip.each { |entry| p entry.get_input_stream.read } # show contents
      zip.each { |entry| p entry.name } # show the name of the files inside
    end  end

  def index
    uri = URI("http://bitly.com/nuvi-plz")
  end

  # def process
  #   # http://bitly.com/nuvi-plz
  #
  #   open([mode [, perm]] [, options]) [{|io| ... }]
  #
  #   zip = Zip::ZipFile.open('some.zip')                 # open zip
  #   entry = zip.entries.reject(&:directory?).first      # take first non-directory
  #   xml_source = entry.get_input_stream{|is| is.read }  # read file contents
  #
  #   # now use the contents of xml_source with Nokogiri
  # end

end
