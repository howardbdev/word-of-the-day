class WordOfTheDay::Word

  attr_accessor :word, :definition, :details, :site_name

  @@all = []

  # self.new({word: 'happy', definition: 'definition will be here', details: 'word details', site_name: 'Merriam Webster'})

  def initialize(attributes = {})
    @word = attributes[:word]
    @definition = attributes[:definition]
    @details = attributes[:details]
    @site_name = attributes[:site_name]
    @@all << self
  end

  def self.all
    @@all
  end

end
