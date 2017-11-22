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

end
