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
    when '1'
      #print list of current Missions
      puts "You've selected Current Missions."
    when '2'
      #print list of past Missions
      puts "You've selected Past Missions."
    when '3'
      #print list of future Missions
      puts "You've selected Future Missions."
    when 'exit'
      puts "Goobye!"
    else
      puts "I'm sorry, that's not an option."
      puts "Please choose from the available options."
      self.main_menu
    end
  end

end
