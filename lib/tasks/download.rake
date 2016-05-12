require 'net/http'
require 'uri'
#require 'zip/zip'

namespace :download do
  desc "Download Zips"
  task :zips do

    url = "http://bitly.com/nuvi-plz"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.path)
    response = http.request(request)
    debugger
    filename = './test.zip'

    # download the zip
    File.open(filename,"wb") do |file|
    end

    # and show it's contents
  #  Zip::ZipFile.open(filename) do |zip|
  #    # zip.each { |entry| p entry.get_input_stream.read } # show contents
  #    zip.each { |entry| p entry.name } # show the name of the files inside
  #  end
  end
end
