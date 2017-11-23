class JPLMissions::CLI

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
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=current&missions_target=&mission_type=&launch_date=#submit')
      list_nav
    when '2'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=past&missions_target=&mission_type=&launch_date=#submit')
      list_nav
    when '3'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=future&missions_target=&mission_type=&launch_date=#submit')
      list_nav
    end
  end

  def list_missions_from_url(url)
    JPLMissions::Mission.clear_all
    missions_array = JPLMissions::Scraper.scrape_missions_from_url(url)
    JPLMissions::Mission.create_missions_from_array(missions_array)
    JPLMissions::Mission.all.each.with_index do |mission, index|
      puts "#{index + 1}: #{mission.title}"
    end
  end

  def list_nav
    puts ""
    puts ">> To learn more, select a mission."
    puts ">> To return to the main menu, enter 'exit.'"
    puts ""
    input = gets.chomp
    if input.between?('1', JPLMissions::Mission.all.size.to_s)
      display_mission_details(input)
      list_nav
    elsif input == "exit"
      main_menu
    else puts "Please select from the available options"
      list_nav
    end
  end

  def display_mission_details(input)
    user_selection = input.to_i - 1
    mission = JPLMissions::Mission.all[user_selection]
    puts "Mission Title: #{mission.title}"
    puts "#{mission.launch_date}"
    puts "About: #{mission.description}"
  end

end
