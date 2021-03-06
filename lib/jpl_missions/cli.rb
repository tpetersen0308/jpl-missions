class JPLMissions::CLI

  def call
    puts "Welcome to NASA JPL Missions!"
    self.start
  end

  def start
    main_menu
    input = gets.chomp
    case input
    when /1|2|3|4/
      #print list of selected Missions
      self.list_missions(input)
    when 'exit'
      exit_cli
    else
      puts "I'm sorry, that's not an option."
      puts "Please choose from the available options."
      self.start
    end
  end

  def main_menu
    puts (<<-DOC)
    What kind of missions would you like to browse?
      1. Current Missions
      2. Past Missions
      3. Future Missions
      4. Proposed Missions
      Enter 'exit' to quit
    DOC
  end

  def exit_cli
    puts "For more information on NASA JPL and their missions,"
    puts "visit https://www.jpl.nasa.gov"
    puts "Goodbye!"
  end

  def list_missions(option)
    case option
    when '1'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=current&missions_target=&mission_type=&launch_date=ascending#submit')
      list_nav
    when '2'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=past&missions_target=&mission_type=&launch_date=ascending#submit')
      list_nav
    when '3'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?search=&type=future&missions_target=&mission_type=&launch_date=ascending#submit')
      list_nav
    when '4'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?type=proposed')
      list_nav
    end
  end

  def list_missions_from_url(url)
    JPLMissions::Mission.clear_all
    JPLMissions::Scraper.create_missions_from_url(url)
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
    if input.to_i.between?(1, JPLMissions::Mission.all.size)
      display_mission_details(input)
      list_nav
    elsif input == "exit"
      start
    else puts "Please select from the available options"
      list_nav
    end
  end

  def display_mission_details(input)
    mission = JPLMissions::Mission.find_from_user_input(input)
    puts "Mission Title: #{mission.title}"
    puts "#{mission.launch_date}"
    puts "About: #{mission.description}"
  end

end
