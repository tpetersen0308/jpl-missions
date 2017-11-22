class Mission
  attr_accessor :title, :launch_date, :description
  @@all = []

  def initialize(title)
    self.title = title
    save
  end

  def create_missions_from_array(array)
    array.each do |mission_hash|
      new_mission = Mission.new(mission_hash[:title])
      new_mission.launch_date = mission_hash[:launch_date]

  def save
    @@all << self
  end

end
