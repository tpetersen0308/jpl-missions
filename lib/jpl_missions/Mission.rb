class JPLMissions::Mission
  attr_accessor :title, :launch_date, :description, :details
  @@all = []

  def initialize(title, launch_date, description)
    self.title = title
    self.launch_date = launch_date
    self.description = description
    save
  end

  def self.find_from_user_input(input)
    self.all[input.to_i - 1]
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.clear_all
    @@all.clear
  end

end
