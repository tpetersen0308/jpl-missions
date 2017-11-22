class Scraper

  def self.scrape_missions_from_url(url)
    missions = []
    Nokogiri::HTML(open(url)).css("div.list_text_content").each do |mission|
      new_mission = {}
      new_mission[:title] = mission.css(".content_title").text.strip
      new_mission[:launch_date] = mission.css(".article_teaser_body").first.text
      new_mission[:description] = mission.css(".article_teaser_body").last.text.strip
      missions << new_mission
    end

    missions
  end

  def self.scrape_mission_from_user_selection(option)
    mission_details = {}
    slug = Mission[option].title.downcase.gsub(' ','-')
    doc = Nokogiri::HTML(open("https://www.jpl.nasa.gov/missions/#{slug}")).css('article')
    mission_details[:about_the_mission] = doc.css("div.wysiwyg_content p").first.text
    mission_details
  end

end
