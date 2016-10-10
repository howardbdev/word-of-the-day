class WordOfTheDay::CLI

  def call
    puts "WELCOME TO YOUR WORDS OF THE DAY!!!"
    puts
      list_words
      run
      goodbye
  end

  def list_words
    @words = WordOfTheDay::Words.today
    @words.each_with_index do |word, i|
      puts "#{i+1}. #{word.site_name}:"
      puts "#{word.word}"
    end
    show_options
  end

  def run
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0 && input.to_i <= @words.length
        the_word = @words[input.to_i - 1]
        puts "----------------------------------------------------------"
        puts "#{the_word.word}" unless the_word.site_name == "WordThink" || the_word.site_name == "The Free Dictionary"
        puts "#{the_word.definition}"
        puts "#{the_word.details}"
        puts "----------------------------------------------------------"
        show_options
      elsif input == "list"
        list_words
      else
        puts "Invalid entry." unless input == "exit"
        show_options
      end

    end
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
