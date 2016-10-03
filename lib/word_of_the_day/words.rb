class WordOfTheDay::Words

  attr_accessor :word, :definition, :date, :didja_know, :example, :site_name

  def self.today
    self.scrape_words
  end #today

  def self.scrape_words
    words = []
    words << self.scrape_mw
    words << self.scrape_dictionary
    words << self.scrape_wordthink
    words
  end #scrape_words

  def self.scrape_mw
    doc = Nokogiri::HTML(open("http://www.merriam-webster.com/word-of-the-day"))
    word_mw = self.new
    word_mw.site_name = "Merriam-Webster"
    word_mw.date = doc.search(".w-a-title").text.strip
    word_mw.word = doc.search(".word-and-pronunciation h1").text.strip
    word_mw.definition = "#{doc.search(".main-attr").text.strip}, #{doc.search(".wod-definition-container p").first.text.strip}"
    word_mw.didja_know = doc.search(".wod-did-you-know-container").text.strip
    # binding.pry
    word_mw
  end #scrape_mw

  def self.scrape_dictionary
    doc = Nokogiri::HTML(open("http://www.dictionary.com/wordoftheday/"))
    word_dic = self.new
    word_dic.site_name = "Dictionary.com"

    word_dic.word = doc.search(".definition-header strong").text.strip
    word_dic.date = doc.search(".date-wrapper").text.strip
    word_dic.definition = doc.search(".first").text.strip
    word_dic.didja_know = doc.search(".origin-content").text.strip

    word_dic
  end #scrape_dictionary

  def self.scrape_wordthink
    doc = Nokogiri::HTML(open("http://www.wordthink.com/"))
    word_wt = self.new
    word_wt.site_name = "WordThink"

    word_wt.word = doc.search(".title").first.text.strip
    word_wt.date = "#{doc.search(".months").first.text.strip} #{doc.search(".dates").first.text.strip} #{doc.search(".years").first.text.strip} "
    word_wt.definition = doc.search("p").first.text.strip
    # word_wt.didja_know = doc.search().text.strip

    # word_wt.word = "hard code - word"
    # word_wt.date = "hard code - date"
    # word_wt.definition = "hard code - definition"
    word_wt.didja_know = "hard code - didja_know"

    word_wt
  end #scrape_dictionary

end #class
