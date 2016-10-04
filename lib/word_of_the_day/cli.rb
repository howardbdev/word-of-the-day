class WordOfTheDay::CLI

  def call
    puts "WELCOME TO YOUR WORDS OF THE DAY!!!"
      list_words
      menu
      goodbye
  end #list_call

  def list_words
    @words = WordOfTheDay::Words.today
    @words.each_with_index do |word, i|
      puts "#{i+1}. #{word.site_name} -- #{word.date}"
      puts "Today's word: #{word.word}"
      puts "#{word.definition}"
      #puts "#{word.didja_know}"
    end #each_with_index

  end #list_words

  def menu
    #puts "Enter your word number:"
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i > 0
        the_word = @words[input.to_i - 1]
        puts "##{the_word.word} - #{the_word.definition} - #{the_word.example}"
      elsif input == "list"
        list_deals
      else
        #puts "Type list, word number, or exit"
      end # if
    end # while
  end ##menu

  def goodbye
    puts "Adios!  See you tomorrrow for more words!!!"
  end

end
