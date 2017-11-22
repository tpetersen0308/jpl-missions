class Mission
  attr_accessor :title, :launch_date, :description
  @@all = []

  def initialize(title)
    self.title = title
    save
  end

  def save
    @@all << self
  end

end
