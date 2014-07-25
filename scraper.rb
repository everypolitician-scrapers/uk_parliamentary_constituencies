
# Fetch voting information from riigikogu.ee

require 'scraperwiki'
require 'nokogiri'
require 'open-uri'

@URL = 'http://en.wikipedia.org/wiki/List_of_United_Kingdom_Parliament_constituencies'

doc = Nokogiri::HTML(open(@URL).read)
data = doc.css("table.wikitable tr").drop(1).map do |tr|
  cells = tr.css('td')
  { constituency: cells[0].text, country: cells[-1].text }
end

ScraperWiki.save_sqlite([:constituency], data)

