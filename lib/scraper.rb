class Scraper

  def self.scrape_missions_from_url(url)
    missions = []
    Nokogiri::HTML(open(url)).css("div.list-text-content").each do |mission|
      new_mission = {}
      new_mission[:title] = mission.css(".content_title").text.strip
      new_mission[:launch_date] = mission.css(".article_teaser_body").first.text
      new_mission[:description] = mission.css(".article_teaser_body").last.text
      missions << new_mission
    end

    missions
  end

end
