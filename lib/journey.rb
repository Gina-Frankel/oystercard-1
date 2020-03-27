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

  def fare
    if !!@exit && !!@entry
      1
    else
      6
    end
  end
end