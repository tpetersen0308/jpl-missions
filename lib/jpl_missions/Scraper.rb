class JPLMissions::Scraper

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_missions_from_url(url)
    self.get_page(url).css("div.list_text_content").collect do |mission|
      new_mission = {}
      new_mission[:title] = mission.css(".content_title").text.strip
      new_mission[:launch_date] = mission.css(".article_teaser_body").first.text
      new_mission[:description] = mission.css(".article_teaser_body").last.text.strip
      new_mission
    end
  end

  def self.create_missions_from_url(url)
    self.scrape_missions_from_url(url).each do |mission_hash|
      JPLMissions::Mission.new(mission_hash[:title], mission_hash[:launch_date], mission_hash[:description])
    end
  end

end
