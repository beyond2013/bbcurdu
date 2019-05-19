require 'rubygems'
require 'nokogiri'
require 'open-uri'

def gather_url(url)
	encoded_url = URI.encode(url)
	doc = Nokogiri::HTML(open(encoded_url))
	base_url = "https://www.bbc.com"
	url_array = [encoded_url]
	relatedArticles = doc.search("//ul[@class='units-list ']/li/a/@href")
	relatedArticles.each do |rarticle|
		complete_url = base_url + rarticle.value
	  url_array << complete_url	
	end
 scrap(url_array)
end

def scrap(url_array)
	url_array.each do |element|
		puts element
		encoded_url = URI.encode(element)
		doc = Nokogiri::HTML(open(encoded_url))
		article =""
		node = doc.search("//div[@class='story-body']/h1")
		article +="#{node.text}\n"
		author = doc.search("//span[@class='byline__name']")
		article +="#{author.text}\n"
		tags = doc.search("//ul[@class='tags-list']/li/a")
		tags.each do |tag|
			if tag.child && tag.child.text?
				article += "#{tag.child}\t"
			end
		end
		article += "\n"
		nodes = doc.search("//div[@class='story-body__inner']/p")
		nodes.each do |node|
			if node.child && node.child.text?
				article +=  "#{node.child}\n"
			end
		end
		writeToFile(article)
	end
end


def writeToFile(contents)
filename = "./data/"
print "Enter file name to save the contents of news article: \t"
filename << gets.chomp
filename << ".txt"
fh = File.new(filename.chomp, "w")
fh.puts contents
fh.close
puts "contents written to file #{filename}" 
end


print "Enter url of the bbc news article:"
url = gets.chomp
gather_url(url)

