class WordOfTheDay::Scraper

  def self.scrape_words
    scrape_merriam_webster
    scrape_dictionary
    scrape_wordthink
    scrape_wordnik
    scrape_thefreedictionary
  end

  def self.scrape_merriam_webster
    doc = Nokogiri::HTML(open("http://www.merriam-webster.com/word-of-the-day"))
    definition = ''
    doc.search(".wod-definition-container p").each do |element|
      definition << element.text + "\n"
    end
    WordOfTheDay::Word.new(
      site_name: "Merriam-Webster",
      word: doc.search(".word-and-pronunciation h1").text.strip,
      definition: definition,
      details: doc.search("body > div.outer-container > div > div.main-wrapper.clearfix > main > article > div.lr-cols-area.clearfix.sticky-column > div.left-content > div > div.wod-definition-container > p:nth-child(5)").text.strip
    )
  end

  def self.scrape_dictionary
    doc = Nokogiri::HTML(open("http://www.dictionary.com/wordoftheday/"))
    if doc.search(".second").text.length > 3
      definition = "1. " + doc.search(".first").text.strip + " 2. " + doc.search(".second").text.strip
    else definition = doc.search(".first").text.strip
    end
    WordOfTheDay::Word.new(
      site_name: "Dictionary.com",
      word: doc.search(".definition-header strong").text.strip,
      definition: definition,
      details: doc.search("#wotd-2016-10-10 > div.smart-box-container > div.citation-wrapper.smart-item > div > blockquote:nth-child(2)").text.strip
      )
  end

  def self.scrape_wordthink
    doc = Nokogiri::HTML(open("http://www.wordthink.com/"))
    WordOfTheDay::Word.new(
      site_name: "WordThink",
      word: doc.search(".title").first.text.strip,
      definition: doc.search("p").first.text.strip
      )
  end

  def self.scrape_wordnik
    doc = Nokogiri::HTML(open("https://www.wordnik.com/word-of-the-day"))
    WordOfTheDay::Word.new(
      site_name: "Wordnik.com",
      word: doc.search("h1").text.strip,
      definition: doc.search("#define > div > ul > li").text,
      details: doc.search("#wotd > div.content_column > div.word-module.module-examples > ul > li:nth-child(1) > p.text").text.strip + " - " + doc.search("#wotd > div.content_column > div.word-module.module-examples > ul > li:nth-child(1) > p.source > a").text.strip
    )
  end

  def self.scrape_thefreedictionary
    doc = Nokogiri::HTML(open("http://www.thefreedictionary.com/"))
    WordOfTheDay::Word.new(
      site_name: "The Free Dictionary",
      word: doc.search("h3").first.text.strip,
      definition:  doc.search("#Content_CA_WOD_0_DataZone").text.strip[0...-9].gsub("Usage", "  Usage")
     )
  end

end
