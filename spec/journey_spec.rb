require './lib/journey'

describe Journey do
  subject(:journey) { Journey.new("edgeware") }

# TODO: attributes
  context 'attributes' do 
    it 'returns an empty list of journeys by default' do
      expect(journey.journey_history).to eq []
    end
    it 'returns nil for entry_station' do
      expect(journey.entry_station).to eq "edgeware"
    end 
    it 'returns nil for exit_station' do
      expect(journey.exit_station).to eq nil
    end 
  end 

# TODO finish method 

  context '#finish' do
    it "method takes an argument of exit_station" do 
      expect(journey). to respond_to(:finish).with(1).argument
    end 
    
    it 'finishes the journey by updating @journeys array with exit_station' do 
      # let(:correct_answer_dbl) { double("This is needed but doesn't matter??", correct?: true) }
      journey.finish("waterloo")
      expect(journey.journey_history).to eq [{:entry => "edgeware", :exit =>"waterloo"}]
    end 

    end 

end 
   # TODO complete? method 
   # TODO in fare method 

