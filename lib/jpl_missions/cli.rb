class JPLMissions::CLI

  def call
    puts "Welcome to NASA JPL Missions!"
    self.start
  end

  def start
    main_menu
    input = gets.chomp
    case input
    when /1|2|3/
      #print list of selected Missions
      self.display_menu_choice(input)
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
    How would you like to browse missions?
      1. By Status
      2. By Target
      3. By Type
      Enter 'exit' to quit
    DOC
    binding.pry
  end

  def type_menu
    targets = JPLMissions::Scraper.scrape_list_items('https://www.jpl.nasa.gov/missions/?search=&type=&missions_target=&mission_type=&launch_date=#submit', 2)
    targets.each.with_index do |target, index|
      puts "#{index}. #{target}"
    end
  end

  def target_menu
    targets = JPLMissions::Scraper.scrape_list_items('https://www.jpl.nasa.gov/missions/?search=&type=&missions_target=&mission_type=&launch_date=#submit', 1)
    targets.each.with_index do |target, index|
      puts "#{index}. #{target}"
    end
  end

  def status_menu
    targets = JPLMissions::Scraper.scrape_list_items('https://www.jpl.nasa.gov/missions/?search=&type=&missions_target=&mission_type=&launch_date=#submit', 0)
    targets.each.with_index do |target, index|
      puts "#{index}. #{target}"
    end
  end

  def exit_cli
    puts "For more information on NASA JPL and their missions,"
    puts "visit https://www.jpl.nasa.gov"
    puts "Goodbye!"
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
    when '4'
      list_missions_from_url('https://www.jpl.nasa.gov/missions/?type=proposed')
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
