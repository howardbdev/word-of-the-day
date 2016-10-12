class WordOfTheDay::Words

  attr_accessor :word, :definition, :details, :site_name

  def self.today
    self.scrape_words
  end

  def self.scrape_words
    words = []
    words << self.scrape_merriam_webster
    words << self.scrape_dictionary
    words << self.scrape_wordthink
    words << self.scrape_wordnik
    words << self.scrape_thefreedictionary
    words
  end

  def self.scrape_merriam_webster
    doc = Nokogiri::HTML(open("http://www.merriam-webster.com/word-of-the-day"))
    word_mw = self.new
    word_mw.site_name = "Merriam-Webster"
    word_mw.word = doc.search(".word-and-pronunciation h1").text.strip
    word_mw.definition = ""
    doc.search(".wod-definition-container p").each do |element|
      word_mw.definition << element.text + "\n"
    end
    word_mw.details = doc.search("body > div.outer-container > div > div.main-wrapper.clearfix > main > article > div.lr-cols-area.clearfix.sticky-column > div.left-content > div > div.wod-definition-container > p:nth-child(5)").text.strip
    word_mw
  end

  def self.scrape_dictionary
    doc = Nokogiri::HTML(open("http://www.dictionary.com/wordoftheday/"))
    word_dic = self.new
    word_dic.site_name = "Dictionary.com"
    word_dic.word = doc.search(".definition-header strong").text.strip
    if doc.search(".second")
      word_dic.definition = "1. " + doc.search(".first").text.strip + " 2. " + doc.search(".second").text.strip
    else word_dic.definition = doc.search(".first").text.strip
    end
    word_dic.details = doc.search("#wotd-2016-10-10 > div.smart-box-container > div.citation-wrapper.smart-item > div > blockquote:nth-child(2)").text.strip
    word_dic
  end

  def self.scrape_wordthink
    doc = Nokogiri::HTML(open("http://www.wordthink.com/"))
    word_wt = self.new
    word_wt.site_name = "WordThink"
    word_wt.word = doc.search(".title").first.text.strip
    word_wt.definition = doc.search("p").first.text.strip
    word_wt
  end

  def self.scrape_wordnik
    doc = Nokogiri::HTML(open("https://www.wordnik.com/word-of-the-day"))
    wrd = self.new
    wrd.site_name = "Wordnik.com"
    wrd.word = doc.search("h1").text.strip
    wrd.definition = doc.search("#define > div > ul > li").text
    wrd.details = doc.search("#wotd > div.content_column > div.word-module.module-examples > ul > li:nth-child(1) > p.text").text.strip + " - " + doc.search("#wotd > div.content_column > div.word-module.module-examples > ul > li:nth-child(1) > p.source > a").text.strip
    wrd
  end

  def self.scrape_thefreedictionary
    doc = Nokogiri::HTML(open("http://www.thefreedictionary.com/"))
    wrd = self.new
    wrd.site_name = "The Free Dictionary"
    wrd.word = doc.search("h3").first.text.strip
    wrd.definition = doc.search("#Content_CA_WOD_0_DataZone").text.strip[0...-9].gsub("Usage", "  Usage")
    wrd
  end

end
