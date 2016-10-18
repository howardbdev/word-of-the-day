class WordOfTheDay::CLI

  attr_accessor :words

  def call
    puts "WELCOME TO YOUR WORDS OF THE DAY!!!"
    puts Date.today
    puts
      list_words
      run
      goodbye
  end

  def list_words
    WordOfTheDay::Scraper.scrape_words if WordOfTheDay::Word.all.empty?
    WordOfTheDay::Word.all.each_with_index do |word, i|
      puts "#{i+1}. #{word.site_name}:"
      puts "#{word.word}"
    end
    show_options
  end

  def run
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= WordOfTheDay::Word.all.length
        the_word = WordOfTheDay::Word.all[input.to_i - 1]
        display_word_details(the_word)
        show_options
      elsif input == "list"
        list_words
      elsif input == "exit"
        break
      else
          puts "Invalid entry."
          show_options
      end

    end
  end

  def display_word_details(the_word)
    puts "----------------------------------------------------------"
    puts "#{the_word.site_name}"
    puts "#{the_word.word}" unless the_word.site_name == "WordThink" || the_word.site_name == "The Free Dictionary"
    puts "#{the_word.definition}"
    puts "#{the_word.details}"
    puts "----------------------------------------------------------"
  end

  def show_options
    puts
    puts "Type the number of a word to show definition and usage."
    puts "Type 'list' to show the list of words again or 'exit' to exit."
    puts
  end

  def goodbye
    puts "Adios!  See you tomorrow for more words!!!"
  end

end
