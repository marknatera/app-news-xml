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
          forum = xml_doc.elements.xpath("forum").text
          forum_title = xml_doc.elements.xpath("forum_title").text
          discussion_title = xml_doc.elements.xpath("discussion_title").text
          language = xml_doc.elements.xpath("language").text
          topic_url = xml_doc.elements.xpath("topic_url").text
          topic_text = xml_doc.elements.xpath("topic_text").text
          spam_score = xml_doc.elements.xpath("spam_score").text
          post_num = xml_doc.elements.xpath("post_num").text
          post_id = xml_doc.elements.xpath("post_id").text
          post_url = xml_doc.elements.xpath("post_url").text
          post_date = xml_doc.elements.xpath("post_date").text
          post_time = xml_doc.elements.xpath("post_time").text
          username = xml_doc.elements.xpath("username").text
          post = xml_doc.elements.xpath("post").text
          country = xml_doc.elements.xpath("country").text
          main_image = xml_doc.elements.xpath("main_image").text
          identifier = ("#{forum}" + "#{forum_title}" + "#{discussion_title}" + "#{post_id}").gsub(' ', '_').downcase

          news = NewsXml.find_or_initialize_by(identifier: identifier)
          news[:forum]                = forum            || ''
          news[:forum_title]          = forum_title      || ''
          news[:discussion_title]     = discussion_title || ''
          news[:language]             = language         || ''
          news[:topic_url]            = topic_url        || ''
          news[:topic_text]           = topic_text       || ''
          news[:spam_score]           = spam_score       || ''
          news[:post_num]             = post_num         || ''
          news[:post_id]              = post_id          || ''
          news[:post_url]             = post_url         || ''
          news[:post_date]            = post_date        || ''
          news[:post_time]            = post_time        || ''
          news[:username]             = username         || ''
          news[:post]                 = post             || ''
          news[:country]              = country          || ''
          news[:main_image]           = main_image       || ''
          news[:identifier]           = identifier
          news.save

          debugger

        end

      end
    end
  end
end
