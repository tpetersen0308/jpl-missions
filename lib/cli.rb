class CLI

  def call
    puts "Welcome to NASA JPL Missions!"
    self.main_menu
  end

  def main_menu
    puts (<<-DOC)
    What kind of missions would you like to browse?
      1. Current Missions
      2. Past Missions
      3. Future Missions
      Enter 'exit' to quit
    DOC
    input = gets.chomp
    case input
    when /1|2|3/
      #print list of selected Missions
      self.list_missions(input)
    when 'exit'
      puts "Goobye!"
    else
      puts "I'm sorry, that's not an option."
      puts "Please choose from the available options."
      self.main_menu
    end
  end

  def list_missions(option)
    case option
    when '1'
      puts "Juno"
    when '2'
      puts 'Cassini'
    when '3'
      puts "Europa"
    end
  end

end
