class Journey
  attr_reader :journey_history, :entry_station, :exit_station
  def initialize(entry_station)
    @journey_history = []
    @entry_station = entry_station
    @exit_station
  end
    def finish(exit_station)
      @journey = Hash.new 
      @journey[:entry] = @entry_station
      @journey[:exit] = exit_station
      @journey_history.push(@journey)
    end 
end


