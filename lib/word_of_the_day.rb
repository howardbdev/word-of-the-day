module WordOfTheDay

end

require 'nokogiri'
require 'pry'
require 'open-uri'
require 'date'

require_relative "./word_of_the_day/version"
require_relative "./word_of_the_day/cli"
require_relative "./word_of_the_day/word"
require_relative "./word_of_the_day/scraper"
