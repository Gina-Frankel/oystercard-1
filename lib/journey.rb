class Journey
  def initialize
    @entry = nil
    @exit = nil
  end

  attr_reader :entry, :exit

  def start(station)
    @entry = station
  end

  def finish(station)
    @exit = station
  end
end