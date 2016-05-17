require 'rubygems'
require 'nokogiri'
require 'zip'
require 'open-uri' # load open-uri library if the input is from the Internet

namespace :download do
  desc 'download files'
  task :process => :environment do
    starting_url = 'http://bitly.com/nuvi-plz'
    final_uri = nil
    doc = Nokogiri::HTML(open(starting_url))
    url = open(starting_url) { |io| final_uri = io.base_uri }

    zip_file_names = []

    doc.css('table tr td a @href').each_with_index do |th,i|
      next if i == 0
      zip_file_names << th.value
    end

    # This part belongs on a Redis
    zip_file_names.each do |zip_name|

      zip_url = final_uri.to_s + zip_name
      zip_folder = zip_name.gsub(/.zip/, '')

      # download the zip
      File.open("public/zips/#{zip_name}", "wb") do |saved_file|
        # the following "open" is provided by open-uri
        open("#{zip_url}", "rb") do |read_file|
          saved_file.write(read_file.read)
          puts "Saved #{zip_url}"

          # zip_folder = zip_name.gsub(/.zip/, '')
          # FileUtils.mkdir_p("public/zips/#{zip_folder}") unless File.directory?("public/zips/#{zip_folder}")
          # puts "Directory #{zip_folder} created"

          Zip::File.open("public/zips/#{zip_name}") do |zip_file|
            zip_file.each do |f|
              f_path = File.join("public/zips/#{zip_folder}", f.name)
              FileUtils.mkdir_p(File.dirname(f_path))
              zip_file.extract(f, f_path) unless File.exist?(f_path)
            end
          end

          # doc.css('table tr td a @href').each_with_index do |th,i|
          #   next if i == 0
          #   zip_file_names << th.value
          # end

          # view_xml = File.open("blossom.xml") { |f| Nokogiri::XML(f) }

          # Zip::File.open("public/zips/#{zip_name}") do |zip_file|
          #   zip_file.each do |entry|
          #     # Extract to file/directory/symlink
          #     puts "Extracting #{entry.name}"
          #     entry.extract("public/zips/#{zip_folder}/")
          #     # Read into memory
          #     content = entry.get_input_stream.read
          #   end
          #   #
          #   entry = zip_file.glob('*.xml').first
          #   puts entry.get_input_stream.read
          #
          # end
        end

        xml_files = Dir["public/zips/#{zip_folder}/*.xml"]

        xml_files.each do |file|
          xml_doc = File.open(file) { |f| Nokogiri::XML(f) }
          debugger

# news_xmls = news_xml.create([
#   {
#     name: 'Utah Intervention Medicine (Ogden)',
#     abbreviation: 'Ogden',
#     address: '413 Washington Blvd',
#     city: 'Ogden',
#     state: 'UT',
#     zipcode: '84404',
#     phone: '(801) 615-2884',
#     fax: '',
#     active: true,
#     account_id: 2
#   }
# ])
        end

      end
    end
  end
end
