class Mission
  attr_accessor :title, :launch_date, :description
  @@all = []

  def initialize(title)
    self.title = title
    save
  end

  def self.create_missions_from_array(array)
    array.each do |mission_hash|
      new_mission = self.new(mission_hash[:title])
      new_mission.launch_date = mission_hash[:launch_date]
      new_mission.description = mission_hash[:description]
    end
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

end
