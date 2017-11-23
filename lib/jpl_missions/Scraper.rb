class JPLMissions::Scraper

  def self.get_page(url)
    Nokogiri::HTML(open(url))
  end

  def self.scrape_missions_from_url(url)
    missions = []
    self.get_page(url).css("div.list_text_content").each do |mission|
      new_mission = {}
      new_mission[:title] = mission.css(".content_title").text.strip
      new_mission[:launch_date] = mission.css(".article_teaser_body").first.text
      new_mission[:description] = mission.css(".article_teaser_body").last.text.strip
      missions << new_mission
    end

    missions
  end

  def self.scrape_list_items(url, attr_name)
    list_items = []
    self.get_page(url).css("select").attribute(attr_name).css("option").each do |item|
      list_items << item.text
    end
    list_items
  end


end
