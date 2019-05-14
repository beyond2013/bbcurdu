require 'rubygems'
require 'nokogiri'
require 'open-uri'
print "Enter url of the bbc news article: \t"
url = gets
encoded_url = URI.encode(url)
doc = Nokogiri::HTML(open(URI.parse(encoded_url)))
@notice =""
#	node = doc.search("//div[@class='g-container']/h1")
	node = doc.search("//div[@class='story-body']/h1")
	@notice +="#{node.text}\n"
	#nodes = doc.search("//div[@class='bodytext']/p")
	nodes = doc.search("//div[@class='story-body__inner']/p")
	nodes.each do |node|
		if node.child && node.child.text?
			@notice +=  "#{node.child}\n"
		end
	end

filename = "./data/"
print "Enter file name to save the contents of news article: \t"
filename << gets.chomp
filename << ".txt"
fh = File.new(filename.chomp, "w")
fh.puts @notice
fh.close
puts "contents written to file #{filename}" 
