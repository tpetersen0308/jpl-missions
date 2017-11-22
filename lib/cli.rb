class CLI

  def call
    puts "Welcome to NASA JPL Missions!"
    self.main_menu
    puts "For more information on NASA JPL and their missions,"
    puts "visit https://www.jpl.nasa.gov"
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
      puts "Goodbye!"
    else
      puts "I'm sorry, that's not an option."
      puts "Please choose from the available options."
      self.main_menu
    end
  end

  def list_missions(option)
    case option
    when '1'
      missions_array = Scraper.scrape_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=current&missions_target=&mission_type=&launch_date=#submit')
      Mission.create_missions_from_array(missions_array)
      Mission.all.each.with_index do |mission, index|
        puts "#{index + 1}: #{mission.title}"
      end
    when '2'
      missions_array = Scraper.scrape_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=past&missions_target=&mission_type=&launch_date=#submit')
      Mission.create_missions_from_array(missions_array)
      Mission.all.each.with_index do |mission, index|
        puts "#{index + 1}: #{mission.title}"
      end
    when '3'
      missions_array = Scraper.scrape_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=future&missions_target=&mission_type=&launch_date=#submit')
      Mission.create_missions_from_array(missions_array)
      Mission.all.each.with_index do |mission, index|
        puts "#{index + 1}: #{mission.title}"
      end
    end
  end

end
