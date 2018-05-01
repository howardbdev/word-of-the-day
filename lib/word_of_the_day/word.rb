class WordOfTheDay::Word

  attr_accessor :word, :definition, :details, :site_name

  @@all = []

  def initialize(attributes = {})
    attributes.each { |attr_name, value| self.send("#{attr_name}=", value) }
    # @word = attributes[:word]
    # @definition = attributes[:definition]
    # @details = attributes[:details]
    # @site_name = attributes[:site_name]
    @@all << self
  end

  def self.all
    @@all
  end

end
